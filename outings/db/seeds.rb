# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do
  password = Faker::Internet.password
  User.create(name:Faker::Name.name, email:Faker::Internet.email, password:password, password_confirmation:password, phone:Faker::PhoneNumber.phone_number,user_name:Faker::Superhero.name, organization_id:1)
end

25.times do
  Location.create(name:Faker::GameOfThrones.city, address:Faker::Address.street_address)
end

User.all.each do |user|
  Plan.create(organizer:user, location: Location.all.sample, timing: Time.now, organization_id: 1)
end
