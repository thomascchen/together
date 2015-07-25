class User < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :building
  has_many :problems, dependent: :destroy
  has_many :solutions, dependent: :destroy
  has_many :problem_votes, dependent: :destroy
  has_many :solution_votes, dependent: :destroy

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

  def name
    "#{first_name} #{last_name}"
  end
end
