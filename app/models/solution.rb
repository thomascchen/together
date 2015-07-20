class Solution < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user
  has_many :solution_votes

  validates :title, presence: true
  validates :description, presence: true
  validates :accepted, inclusion: { in: [true, false] }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :problem_id, presence: true, numericality: { only_integer: true }
end
