class Neighborhood < ActiveRecord::Base
  has_many :buildings
  has_many :users

  validates :name, presence: true, uniqueness: true, inclusion: {
    in: [
      "Allston",
      "Back Bay",
      "Bay Village",
      "Beacon Hill",
      "Brighton",
      "Charlestown",
      "Chinatown",
      "Dorchester",
      "Downtown",
      "East Boston",
      "Fenway Kenmore",
      "Hyde Park",
      "Jamaica Plain",
      "Mattapan",
      "Mission Hill",
      "North End",
      "Roslindale",
      "Roxbury",
      "South Boston",
      "South End",
      "West End",
      "West Roxbury"
    ]
  }
end
