class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.boolean :accepted, null: false, default: 'false'
      t.integer :user_id, null: false
      t.integer :problem_id, null: false
      t.timestamps null: false
    end
  end
end
