class Disk < ActiveRecord::Base

	# Relationships

	belongs_to :machine
	has_many :alerts, as: :alertable
end