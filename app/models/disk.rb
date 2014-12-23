class Disk < ActiveRecord::Base

	# Relationships

	belongs_to :machine
	has_many :alerts, as: :alertable

	# Properties

	validates :name, :serial_number, :capacity, :format, presence: true
	validates :name, uniqueness: { case_sensitive: false }
	
end