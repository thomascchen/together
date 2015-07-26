# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Neighborhood.find_or_create_by(name: "Allston") # 1
Neighborhood.find_or_create_by(name: "Back Bay") # 2
Neighborhood.find_or_create_by(name: "Bay Village") # 3
Neighborhood.find_or_create_by(name: "Beacon Hill") # 4
Neighborhood.find_or_create_by(name: "Brighton") # 5
Neighborhood.find_or_create_by(name: "Charlestown") # 6
neighborhood = Neighborhood.find_or_create_by(name: "Chinatown") # 7
Neighborhood.find_or_create_by(name: "Dorchester") # 8
Neighborhood.find_or_create_by(name: "Downtown") # 9
Neighborhood.find_or_create_by(name: "East Boston") # 10
Neighborhood.find_or_create_by(name: "Fenway Kenmore") # 11
Neighborhood.find_or_create_by(name: "Hyde Park") # 12
Neighborhood.find_or_create_by(name: "Jamaica Plain") # 13
Neighborhood.find_or_create_by(name: "Mattapan") # 14
Neighborhood.find_or_create_by(name: "Mission Hill") # 15
Neighborhood.find_or_create_by(name: "North End") # 16
Neighborhood.find_or_create_by(name: "Roslindale") # 17
Neighborhood.find_or_create_by(name: "Roxbury") # 18
Neighborhood.find_or_create_by(name: "South Boston") # 19
Neighborhood.find_or_create_by(name: "South End") # 20
Neighborhood.find_or_create_by(name: "West End") # 21
Neighborhood.find_or_create_by(name: "West Roxbury") # 22

building = Building.find_or_create_by(
  street: '33 Harrison Ave.',
  city: 'Boston',
  state: 'MA',
  zip: '02111',
  neighborhood_id: neighborhood.id
)

User.create(
  email: 'guest@example.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Guest',
  last_name: 'User',
  unit: '1A',
  role: 'tenant',
  building_id: building.id,
  neighborhood_id: neighborhood.id,
  phone: '617-123-4567',
  description: 'This account has been created for demonstration purposes'
)

Category.find_or_create_by(name: 'Repairs')
Category.find_or_create_by(name: 'Heat and Essential')
Category.find_or_create_by(name: 'Security')
Category.find_or_create_by(name: 'Lease')
Category.find_or_create_by(name: 'Security Deposit')
Category.find_or_create_by(name: 'Other')

UrgencyLevel.create(name: 'Immediate')
UrgencyLevel.create(name: 'Soon')
UrgencyLevel.create(name: 'Not Urgent')

Status.find_or_create_by(name: 'Open')
Status.find_or_create_by(name: 'Solved')
