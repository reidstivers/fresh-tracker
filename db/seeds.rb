# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# puts "Cleaning database..."
# Restaurant.destroy_all
require "date"
today = Date.today
futuredate = Date.new(2024, 8, 14)

puts "Checking if Pantry exists ..."
Pantry.create! if Pantry.all.count.zero?

pantry = Pantry.last
pantry.id += 1 if pantry.id != 1
puts "Pantry id is #{pantry.id}"

puts "Creating ingredients..."
wholemilk = { name: "Whole Milk", pantry_id: pantry.id, amount: 1, unit: "carton", expiration_date: today, category: "dairy", in_pantry: true }
broccori = { name: "Broccoli", pantry_id: pantry.id, amount: 2, unit: "", expiration_date: today, category: "vegitables", in_pantry: true }
carrot = { name: "Carrot", pantry_id: pantry.id, amount: 3, unit: "", expiration_date: futuredate, category: "vegitables", in_pantry: true }
kobebeef = { name: "Kobe beef steak", pantry_id: pantry.id, amount: 2, unit: "slice", expiration_date: futuredate, category: "meat", in_pantry: true }
orangejuice = { name: "Orange juice", pantry_id: pantry.id, amount: 500, unit: "ml", expiration_date: futuredate, category: "beverage", in_pantry: true }

[wholemilk, broccori, carrot, kobebeef, orangejuice].each do |attributes|
  ingredient = Ingredient.create!(attributes)
  puts "Created #{ingredient.name}"
end
puts "Finished!"
