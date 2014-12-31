class Disk < ActiveRecord::Base

	# Relationships

	belongs_to :machine
	has_many :alerts, as: :alertable

	# Properties

	validates :name, :serial_number, :capacity, :format, presence: true
	validates :name, uniqueness: { case_sensitive: false }

	# Methods

	def nice_capacity
		if capacity.blank?
			"Unknown size"
		elsif capacity < 1000
			"#{capacity}GB"
		else
			"#{capacity / 1000.0}TB"
		end
	end

	def location
		if machine.blank?
			""
		elsif usage.blank?
			"#{machine.name}"
		else
			"#{machine.name} (#{usage})"
		end
	end
end