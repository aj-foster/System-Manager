class User < ActiveRecord::Base

	# Properties
	validates :name, presence: true
	
end