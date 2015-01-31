class DiskStatus < ActiveRecord::Base

	# Relationship
	belongs_to :disk

	# Properties
	validates :disk, presence: true

	# Default Setup
	before_save :setup_disk_status

	# Evaluate disk status during creation
	after_create :evaluate_status

	private

		def evaluate_status
			@disk = self.disk
			@statuses = DiskStatus.where(disk: @disk).order(created_at: :desc)

			return true unless @statuses.any?
			@current = @statuses.first

			if @current.pending > 0
				Alert.touch(name: "Pending Reallocations", \
							message: "The disk #{@disk.name} has sectors "\
									 "that are waiting to be reallocated. "\
									 "This may indicate an upcoming failure.", \
							alertable: @disk)
			end

			@previous = @statuses.second
			return true if @previous.nil?

			if @current.reallocations > @previous.reallocations
				Alert.touch(name: "Reallocations", \
							message: "The disk #{@disk.name} has seen an "\
									 "increase in the number of reallocated "\
									 "sectors. This may indicate an upcoming "\
									 "failure.", \
							alertable: @disk)
			end

			if @current.uncorrectable > @previous.uncorrectable
				Alert.touch(name: "Uncorrectable Sectors", \
							message: "The disk #{@disk.name} has recently "\
									 "failed to recover data from a sector. "\
									 "This may indicate data loss.", \
							alertable: @disk)
			end
		end

		def setup_disk_status
			self.healthy ||= true
			self.lifetime ||= 0
			self.pending ||= 0
			self.reallocations ||= 0
			self.ssd_wear ||= 0
			self.uncorrectable ||= 0
		end
end