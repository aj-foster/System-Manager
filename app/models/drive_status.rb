class DriveStatus < ActiveRecord::Base

	# Relationships
	#

	# Associate each status with its drive.
	belongs_to :drive


	# Validation
	#

	# Require a drive to be associated with each status.
	validates :drive, presence: true


	# Callbacks
	#

	# Evaluate each new drive status during creation for alertable data.
	after_create :evaluate_status


	private

		# Evaluates a new drive status for data that requires the creation of an
		# alert.
		#
		# Includes the following cases:
		# * There are sectors pending reallocation
		# * The number of reallocated sectors has increased
		# * The number of uncorrectable errors has increased
		#
		def evaluate_status

			# Due to validation, we can be certain that self.drive exists.
			@drive = self.drive

			# Collect previous statuses for the same drive.
			@statuses = DriveStatus.where(drive: @drive).order(created_at: :desc)

			# Ensure there is at least one drive status present.
			return true unless @statuses.any?

			# The most recent drive status, by creation date, is the current one.
			@current = @statuses.first

			# If there are sectors waiting to be reallocated, create an alert.
			if @current.pending > 0
				Alert.touch(name: "Pending Reallocations",
							message: "The drive #{@drive.name} has sectors " \
									 "that are waiting to be reallocated. " \
									 "This may indicate an upcoming failure.",
							alertable: @drive)
			end

			# If there is more than one drive status available, grab the second-
			# most recent in order to evaluate trends in the data.
			@previous = @statuses.second

			# If there is only one status available, we cannot continue.
			return true if @previous.nil?

			# If the number of reallocated sectors has increased, create an
			# alert.
			if @current.reallocations > @previous.reallocations
				Alert.touch(name: "Reallocations",
							message: "The drive #{@drive.name} has seen an " \
									 "increase in the number of reallocated " \
									 "sectors. This may indicate an upcoming " \
									 "failure.",
							alertable: @drive)
			end

			# If the number of uncorrectable errors has increased, create an
			# alert.
			if @current.uncorrectable > @previous.uncorrectable
				Alert.touch(name: "Uncorrectable Sectors",
							message: "The drive #{@drive.name} has recently " \
									 "failed to recover data from a sector. " \
									 "This may indicate data loss.",
							alertable: @drive)
			end
		end
end