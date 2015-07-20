class Problem < ActiveRecord::Base
  belongs_to :user
  belongs_to :status
  belongs_to :urgency_level
  belongs_to :category
  has_many :solutions, dependent: :destroy
  has_many :problem_votes, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :status_id, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates :urgency_level_id, presence: true

  # def votes_tally
  #   votes.sum(:user_vote)
  # end
end
