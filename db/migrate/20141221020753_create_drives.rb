class CreateDrives < ActiveRecord::Migration
  def change
    create_table :drives do |t|
      t.references :machine, index: true
      t.string :name
      t.string :manufacturer
      t.string :serial_number
      t.string :part_number
      t.integer :capacity
      t.string :type
      t.string :usage
      t.date :warranty_exp
      t.text :notes

      t.timestamps
    end
  end
end
