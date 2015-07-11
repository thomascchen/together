class Building < ActiveRecord::Base
  belongs_to :neighborhood

  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true, format: { with: /\d{5}/ }, length: { is: 5 }
  validates :neighborhood_id, presence: true, numericality: {
    only_integer: true
  }
end
