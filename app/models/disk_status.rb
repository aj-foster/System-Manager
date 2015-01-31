class DiskStatus < ActiveRecord::Base

	# Relationships
	#

	# Associate each status with its disk.
	belongs_to :disk


	# Validation
	#

	# Require a disk to be associated with each status.
	validates :disk, presence: true


	# Callbacks
	#

	# Give each status safe default values for comparison purposes.
	before_save :setup_disk_status

	# Evaluate each new disk status during creation for alertable data.
	after_create :evaluate_status


	private

		# Evaluates a new disk status for data that requires the creation of an
		# alert.
		#
		# Includes the following cases:
		# * There are sectors pending reallocation
		# * The number of reallocated sectors has increased
		# * The number of uncorrectable errors has increased
		#
		def evaluate_status

			# Due to validation, we can be certain that self.disk exists.
			@disk = self.disk

			# Collect previous statuses for the same disk.
			@statuses = DiskStatus.where(disk: @disk).order(created_at: :desc)

			# Ensure there is at least one disk status present.
			return true unless @statuses.any?

			# The most recent disk status, by creation date, is the current one.
			@current = @statuses.first

			# If there are sectors waiting to be reallocated, create an alert.
			if @current.pending > 0
				Alert.touch(name: "Pending Reallocations",
							message: "The disk #{@disk.name} has sectors " \
									 "that are waiting to be reallocated. " \
									 "This may indicate an upcoming failure.",
							alertable: @disk)
			end

			# If there is more than one disk status available, grab the second-
			# most recent in order to evaluate trends in the data.
			@previous = @statuses.second

			# If there is only one status available, we cannot continue.
			return true if @previous.nil?

			# If the number of reallocated sectors has increased, create an
			# alert.
			if @current.reallocations > @previous.reallocations
				Alert.touch(name: "Reallocations",
							message: "The disk #{@disk.name} has seen an " \
									 "increase in the number of reallocated " \
									 "sectors. This may indicate an upcoming " \
									 "failure.",
							alertable: @disk)
			end

			# If the number of uncorrectable errors has increased, create an
			# alert.
			if @current.uncorrectable > @previous.uncorrectable
				Alert.touch(name: "Uncorrectable Sectors",
							message: "The disk #{@disk.name} has recently " \
									 "failed to recover data from a sector. " \
									 "This may indicate data loss.",
							alertable: @disk)
			end
		end


		# Gives a disk status safe default values to protect against nil
		# comparisons.
		#
		def setup_disk_status
			self.healthy ||= true
			self.lifetime ||= 0
			self.pending ||= 0
			self.reallocations ||= 0
			self.ssd_wear ||= 0
			self.uncorrectable ||= 0
		end
end