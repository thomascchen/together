class Problem < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :category_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
end
