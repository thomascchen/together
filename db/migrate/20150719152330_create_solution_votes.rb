class CreateSolutionVotes < ActiveRecord::Migration
  def change
    create_table :solution_votes do |t|
      t.integer :user_id, null: false
      t.integer :solution_id, null: false
      t.integer :vote, default: 0
      t.timestamps null: false
    end
  end
end
