class SetDefaults < ActiveRecord::Migration
  def change
  	change_column :machines, :name, :string, default: ""
  	change_column :machines, :location, :string, default: ""
  	change_column :machines, :ip_address, :string, default: ""
  	change_column :machines, :info, :hstore, default: {}

  	change_column :drives, :name, :string, default: ""
  	change_column :drives, :manufacturer, :string, default: ""
  	change_column :drives, :serial_number, :string, default: ""
  	change_column :drives, :part_number, :string, default: ""
  	change_column :drives, :capacity, :integer, default: 0
  	change_column :drives, :format, :string, default: "HDD"
  	change_column :drives, :usage, :string, default: ""
  	change_column :drives, :notes, :text, default: ""

  	change_column :drive_statuses, :lifetime, :integer, default: 0
  	change_column :drive_statuses, :reallocations, :integer, default: 0
  	change_column :drive_statuses, :pending, :integer, default: 0
  	change_column :drive_statuses, :uncorrectable, :integer, default: 0
  	change_column :drive_statuses, :healthy, :boolean, default: true
  	change_column :drive_statuses, :ssd_wear, :integer, default: 0

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
