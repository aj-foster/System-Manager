# Users represent the people who log into the application. These objects will
# be used for authentication and authorization via the role attribute. Devise
# handles the creation and password management of all users.
#
# ==== Fields
#
# * +name+ - Represents the name of the person logging in with this account.
# * +email+ - Used by Devise to authenticate, and the address to which alerts
#   are sent.
# * +role+ - Distinguishes between approved and unapproved users.
# * +send_alerts+ - Used to enable or disable alert emails.
#
class User < ActiveRecord::Base

	# Devise
	#
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable, :validatable

	# Properties
	#
	validates :name, presence: true


	# Callbacks
	#

	# Give users safe default attributes.
	after_initialize :setup_user


	private

		# Gives users a default role of unapproved for security, and do not send
		# alert emails.
		#
		def setup_user
			self.role ||= :unapproved
			self.send_alerts ||= false
		end
end