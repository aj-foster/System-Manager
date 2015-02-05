class ChangeDriveTypeToFormat < ActiveRecord::Migration
	def change
		rename_column :drives, :type, :format
	end
end