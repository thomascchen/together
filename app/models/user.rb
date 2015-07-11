class User < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :building
  has_many :problems

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :unit, presence: true
  validates :role, presence: true
  validates :building_id, presence: true, numericality: { only_integer: true }
  validates :neighborhood_id, presence: true, numericality: {
    only_integer: true
  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
