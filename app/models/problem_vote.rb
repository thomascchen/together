class ProblemVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem

  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :problem_id, presence: true, numericality: { only_integer: true }
  validates :vote, inclusion: { in: [0, 1] }
end
