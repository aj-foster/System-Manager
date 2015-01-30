class Alert < ActiveRecord::Base

	# Relationship
	belongs_to :alertable, polymorphic: true


	# Default Setup
	before_save :setup_alert


	# Allows an alert to be created if it doesn't exist or updated with a "+1"
	# if it does.
	#
	# TODO: make arguments to this method match up with attributes of Alerts.

	def self.touch (attrs = nil)

		# Avoid adding +1 to every alert.
		return false if attrs.nil?

		# Trust the caller to use valid attributes, for now.
		@alerts = Alert.where(attrs)

		# If there are existing alerts that meet the criteria, then add 1 to
		# their multiplicity. Otherwise, create a new alert with the given
		# attributes.

		if @alerts.any?
			@alerts.each do |alert|
				alert.multiplicity += 1
				alert.save
			end
		else
			Alert.create(attrs)
		end
	end


	private

		def setup_alert
			self.multiplicity ||= 1
		end
end