class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :category_id, null: false
      t.integer :urgency_level_id, null: false
      t.integer :status_id, null: false, default: 1
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
