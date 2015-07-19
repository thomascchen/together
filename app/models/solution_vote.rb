class SolutionVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :solution

  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :solution_id, presence: true, numericality: { only_integer: true }
  validates :vote, inclusion: { in: [0, 1] }
end
