class Problem < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :status
  validates :category_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
end
