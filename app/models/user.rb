class User < ActiveRecord::Base

	# Devise
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable, :validatable

	# Properties
	validates :name, presence: true
	
end