class SetDefaults < ActiveRecord::Migration
  def change
  	change_column :machines, :name, :string, default: ""
  	change_column :machines, :location, :string, default: ""
  	change_column :machines, :ip_address, :string, default: ""
  	change_column :machines, :info, :hstore, default: {}

  	change_column :disks, :name, :string, default: ""
  	change_column :disks, :manufacturer, :string, default: ""
  	change_column :disks, :serial_number, :string, default: ""
  	change_column :disks, :part_number, :string, default: ""
  	change_column :disks, :capacity, :integer, default: 0
  	change_column :disks, :format, :string, default: "HDD"
  	change_column :disks, :usage, :string, default: ""
  	change_column :disks, :notes, :text, default: ""

  	change_column :disk_statuses, :lifetime, :integer, default: 0
  	change_column :disk_statuses, :reallocations, :integer, default: 0
  	change_column :disk_statuses, :pending, :integer, default: 0
  	change_column :disk_statuses, :uncorrectable, :integer, default: 0
  	change_column :disk_statuses, :healthy, :boolean, default: true
  	change_column :disk_statuses, :ssd_wear, :integer, default: 0

  	change_column :alerts, :name, :string, default: ""
  	change_column :alerts, :message, :string, default: ""
  	change_column :alerts, :multiplicity, :integer, default: 1

  	change_column :users, :name, :string, default: ""
  	change_column :users, :role, :string, default: :unapproved
  	change_column :users, :send_alerts, :boolean, default: false

  	change_column :extended_attributes, :name, :string, default: ""
  	change_column :extended_attributes, :model, :string, default: ""
  end
end
