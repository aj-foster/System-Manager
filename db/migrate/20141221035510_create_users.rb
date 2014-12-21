class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :role
      t.boolean :send_alerts

      t.timestamps
    end
  end
end
