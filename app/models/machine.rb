class Machine < ActiveRecord::Base

	# Relationships

	has_many :disks
	has_many :alerts, as: :alertable

	# Properties
	validates :name, presence: true
	
end