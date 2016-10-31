# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Organization.create(name: "Flatiron School")

20.times do
  password = Faker::Internet.password
  User.create(name:Faker::Name.name, email:Faker::Internet.email, password:password, password_confirmation:password, phone:Faker::PhoneNumber.phone_number,user_name:Faker::Superhero.name, organization_id:Organization.first.id)
end

25.times do
  Location.create(name:Faker::GameOfThrones.city, address:Faker::Address.street_address)
end

10.times do
  Plan.create(organizer_id:User.all.sample.id, location_id: Location.all.sample.id, timing: Time.at((Time.now.to_f - (Time.now + 500000).to_f)*rand + (Time.now + 500000).to_f), organization_id: Organization.first.id)
  Outing.create(plan_id: Plan.last.id, user_id: Plan.last.organizer_id)
end

20.times do
  Review.create(user_id: User.all.sample.id, location_id: Location.all.sample.id, score: rand(5), comment: Faker::Lorem.sentence)
end
