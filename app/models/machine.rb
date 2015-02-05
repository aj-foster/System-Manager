class Machine < ActiveRecord::Base

	# Relationships
	#
	has_many :drives
	has_many :alerts, as: :alertable, dependent: :destroy


	# Validation
	#
	validates :name, presence: true


	# Returns a human-readable string representing the location of the machine,
	# both physically and electronically, depending on the information that is
	# available.
	#
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