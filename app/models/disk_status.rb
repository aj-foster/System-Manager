class DiskStatus < ActiveRecord::Base

	# Relationship
	belongs_to :disk

	# Properties
	validates :disk, presence: true
	
end