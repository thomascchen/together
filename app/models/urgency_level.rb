class UrgencyLevel < ActiveRecord::Base
  has_many :problems

  validates :name, presence: true, uniqueness: true
end
