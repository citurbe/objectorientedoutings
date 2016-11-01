# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Organization.create(name: "Flatiron School")

20.times do
  password = "1234"
  User.create(name:Faker::Name.name, email:Faker::Internet.email, password:password, password_confirmation:password, phone:Faker::PhoneNumber.phone_number,user_name:Faker::Superhero.name, organization_id:Organization.first.id)
end

Location.create(name:"Chipotle", address:"11 Broadway")
Location.create(name:"Fresh and Co", address:"42 Broadway, New York, NY 10004")
Location.create(name:"Reserve Cut", address:"40 Broad St, New York, NY 10004")
Location.create(name:"Burger King", address:"16 Beaver St, New York, NY 10004")
Location.create(name:"Subway", address:"9 Broadway, New York, NY 10004")
Location.create(name:"The Blarney Stone", address:"11 Trinity Pl, New York, NY 10006")
Location.create(name:"Bluestone Lane", address:"30 Broad St, New York, NY 10004")
Location.create(name:"Cafe Bravo", address:"94 Greenwich St, New York, NY 10006")
Location.create(name:"Carvel", address:"9 Broadway, New York, NY 10004")
Location.create(name:"Open Market", address:"15 William St, New York, NY 10005")
Location.create(name:"Insomnia Cookies", address:"76 Pearl St, New York, NY 10004")
Location.create(name:"The White Horse Tavern", address:"25 Bridge St, New York, NY 10004")
Location.create(name:"Ulysses", address:"95 Pearl St, New York, NY 10004")
Location.create(name:"Mad Dog and Beans", address:"83 Pearl St, New York, NY 10004")

10.times do
  Plan.create(organizer_id:User.all.sample.id, location_id: Location.all.sample.id, timing: Time.at((Time.now.to_f - (Time.now + 7*24*60*60).to_f)*rand + (Time.now + 7*24*60*60).to_f), organization_id: Organization.first.id)
  Outing.create(plan_id: Plan.last.id, user_id: Plan.last.organizer_id)
end

20.times do
  Review.create(user_id: User.all.sample.id, location_id: Location.all.sample.id, score: rand(1..5), comment: Faker::Lorem.sentence)
end
