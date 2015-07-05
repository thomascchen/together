class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :street1, null: false
      t.string :street2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.integer :neighborhood_id, null: false
      t.timestamps null: false
    end
  end
end
