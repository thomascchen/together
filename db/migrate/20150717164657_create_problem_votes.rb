class CreateProblemVotes < ActiveRecord::Migration
  def change
    create_table :problem_votes do |t|
      t.integer :user_id, null: false
      t.integer :problem_id, null: false
    end
  end
end
