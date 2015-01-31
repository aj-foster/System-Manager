class Disk < ActiveRecord::Base

	# Relationships
	#

	# Optionally associate a disk with the machine in which it resides.
	belongs_to :machine

	# Disks have many alerts and statuses associated with them.
	has_many :alerts, as: :alertable, dependent: :destroy
	has_many :disk_statuses, dependent: :destroy


	# Validations
	#
	validates :name, :serial_number, :capacity, :format, presence: true
	validates :name, uniqueness: { case_sensitive: false }


	# Returns a human-friendly string with the disk's location and usage
	# depending on the information that is available.
	#
	def location
		if machine.blank?
			"Location Unknown"
		elsif usage.blank?
			"#{machine.name}"
		else
			"#{machine.name} (#{usage})"
		end
	end


	# Returns a human-friendly string representing the disk's size.
	#
	def nice_capacity
		if capacity.blank?
			"Unknown Size"
		elsif capacity < 1000
			"#{capacity}GB"
		else
			"#{capacity / 1000.0}TB"
		end
	end
end