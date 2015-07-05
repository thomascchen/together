class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.date :deadline
      t.string :status, null: false, default: "Open"
      t.integer :category_id, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
