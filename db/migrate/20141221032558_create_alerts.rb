class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :name
      t.string :message
      t.integer :multiplicity
      t.references :alertable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
