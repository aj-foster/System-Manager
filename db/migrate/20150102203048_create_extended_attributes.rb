class CreateExtendedAttributes < ActiveRecord::Migration
  def change
    create_table :extended_attributes do |t|
      t.string :model
      t.string :name

      t.timestamps
    end
  end
end
