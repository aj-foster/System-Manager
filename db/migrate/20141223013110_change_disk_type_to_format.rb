class ChangeDiskTypeToFormat < ActiveRecord::Migration
	def change
		rename_column :disks, :type, :format
	end
end