class Building < ActiveRecord::Base
  belongs_to :neighborhood

  validates_presence_of :street1
  validates_presence_of :city
  validates_presence_of :state
  validates :zip, presence: true, format: { with: /\d{5}/ }, length: { is: 5 }
  validates :neighborhood_id, presence: true, numericality: { only_integer: true }
end
