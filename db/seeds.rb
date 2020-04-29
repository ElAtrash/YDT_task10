# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'Cleaning Database...'
Team.delete_all
User.delete_all

puts 'Creating Teams and Users...'

teams = []
10.times do 
  team = Team.create!({
    name: Faker::Team.unique.name,
    region: Faker::Team.state
  })

  teams << team
end

users_attributes = []
100.times do 
  user = {
    name: Faker::Name.unique.name,
    phone: Faker::PhoneNumber.unique.cell_phone_with_country_code,
    gender: Faker::Gender.binary_type.downcase,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6)
    }

  users_attributes << user
end 

teams.each do |team|
  10.times do
    team.users << User.new(users_attributes.pop)
  end
end

User.create!(users_attributes)

puts 'Done!'

