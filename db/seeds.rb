# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create! email: "admin@gmail.com", password: "12345678", password_confirmation: "12345678"
10.times do
  Product.create! title: Faker::Book.title, price: Faker::Number.decimal(2), user: user
end
