# Alerts give the user warnings about alertable objects (i.e. drives and
# machines) based on data collected by the application. These are displayed
# immediately upon login and they attach themselves to relevant objects.
#
# ==== Fields
#
# * +name+ - A short, reusable name for the alert which summarizes its
#   meaning for an experienced user.
# * +message+ - A longer, more detailed description of the alert.
# * +multiplicity+ - The number of times this alert has been noted.
# * +alertable+ - An optional reference to the object which the alert
#   concerns.
#
class Alert < ActiveRecord::Base

	# Relationships
	#
	belongs_to :alertable, polymorphic: true


	# Allows an alert to be created if it doesn't exist or given +1
	# multiplicity if it does.
	#
	# ==== Parameters
	#
	# * +attrs+ - Attributes of the Alert to touch. These will be passed into
	#   a +where+ query. *Note*: Insufficient attributes supplied by the caller
	#   could cause an increase in multiplicity to many alerts.
	#
	# ==== Example
	#
	#   Alert.touch(name: "Reallocations", message: "...", alertable: @drive)
	#--
	# TODO: make arguments to this method match up with attributes of Alerts.
	#
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
end