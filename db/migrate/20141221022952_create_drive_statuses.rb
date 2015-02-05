class CreateDriveStatuses < ActiveRecord::Migration
  def change
    create_table :drive_statuses do |t|
      t.references :drive, index: true
      t.integer :lifetime
      t.integer :reallocations
      t.integer :pending
      t.integer :uncorrectable
      t.boolean :healthy
      t.integer :ssd_wear

      t.timestamps
    end
  end
end
