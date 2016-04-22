# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# :name, :description, :category_id, :country, :state, :locality, :price, :sub_category_id, :user_id




# Categorias (Carga inicial)
#Category.create(name: 'Hogar')
#Category.create(name: 'Eventos y entretenimiento')

# Estatus de soicitud (Carga inicial)
# RequestStatus.create(name: 'Aceptada')
# RequestStatus.create(name: 'Rechazada')
# RequestStatus.create(name: 'Pendiente')

# Sub categorias (Carga inicial)
"""SubCategory.create(name: 'Plomeria', category_id: 1)
SubCategory.create(name: 'Electricista', category_id: 1)
SubCategory.create(name: 'Pintura', category_id: 1)
SubCategory.create(name: 'Carpinteria', category_id: 1)
SubCategory.create(name: 'Cerrajería', category_id: 1)
SubCategory.create(name: 'Jardineria', category_id: 1)
SubCategory.create(name: 'Albañileria', category_id: 1)
SubCategory.create(name: 'Impermiabilización', category_id: 1)
SubCategory.create(name: 'Reparacion de computadoras', category_id: 1)
SubCategory.create(name: 'Reparacion de equipos electrónicos', category_id: 1)
SubCategory.create(name: 'Limpieza', category_id: 1)
SubCategory.create(name: 'Fletes y mudanza', category_id: 1)

SubCategory.create(name: 'Ambientación', category_id: 2)
SubCategory.create(name: 'Fotorafia y video', category_id: 2)
SubCategory.create(name: 'Juegos infantiles', category_id: 2)
SubCategory.create(name: 'Banquetes', category_id: 2)
SubCategory.create(name: 'Personajes', category_id: 2)"""


# Script para datos de prueba en servicios
"""10.times do
  Service.create(
    name:  Faker::Lorem.words.join(' '),
    description: Faker::Lorem.paragraph,
    category_id: 1,
    sub_category_id: Faker::Number.between(1, 5),
    country: Faker::Address.country,
    state: Faker::Address.state,
    locality: Faker::Address.city,
    price: Faker::Commerce.price,
    user_id: 1,
    published: 1
  )
end"""

# Script para datos de prueba en usuarios
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
