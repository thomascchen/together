class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.string :name, null: false, unique: true
      t.timestamps null: false
    end
  end
end
