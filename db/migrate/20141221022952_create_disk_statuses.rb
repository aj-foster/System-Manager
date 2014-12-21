class CreateDiskStatuses < ActiveRecord::Migration
  def change
    create_table :disk_statuses do |t|
      t.references :disk, index: true
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
