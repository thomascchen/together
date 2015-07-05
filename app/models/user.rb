class User < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :building

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :unit
  validates_presence_of :role
  validates :building_id, presence: true, numericality: { only_integer: true }
  validates :neighborhood_id, presence: true, numericality: { only_integer: true }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
