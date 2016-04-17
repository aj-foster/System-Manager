class CreateMachines < ActiveRecord::Migration
	def change
		create_table :machines do |t|
			t.string :name
			t.string :location
			t.string :ip_address
			# t.hstore :info

			t.timestamps
		end
	end
end