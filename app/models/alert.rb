class Alert < ActiveRecord::Base

	# Relationship
	belongs_to :alertable, polymorphic: true
	
end