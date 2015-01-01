class Machine < ActiveRecord::Base

	# Relationships

	has_many :disks
	has_many :alerts, as: :alertable

	# Properties
	validates :name, presence: true

	# Methods

	def nice_location
		if location.blank? && ip_address.blank?
			"Location Unknown"
		elsif ip_address.blank?
			"#{location}"
		elsif location.blank?
			"#{ip_address}"
		else
			"#{location} &mdash; #{ip_address}".html_safe
		end
	end
	
end