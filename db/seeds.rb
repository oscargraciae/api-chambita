# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

"""10.times do
  Service.create(
    name:  Faker::Lorem.words.join(' '),
    description: Faker::Lorem.paragraph,
    subcategory_id: 1
  )
end"""

"""10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: 'pajaro',
    birthdate: Faker::Date.backward(14),
    cellphone: Faker::PhoneNumber.cell_phone,
    description: Faker::Lorem.paragraph,
    avatar: Faker::Avatar.image,
    location_id: nil,
    email: Faker::Internet.email
  )
end"""
