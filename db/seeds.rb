# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Seed the database with the categories
categories = [
  { name: "Fruits", icon: "fa-solid fa-lemon fa-xl" },
  { name: "Vegetables", icon: "fa-solid fa-carrot fa-xl" },
  { name: "Meat", icon: "fa-solid fa-drumstick-bite fa-xl" },
  { name: "Fish", icon: "fa-solid fa-fish fa-xl" },
  { name: "Dairy", icon: "fa-solid fa-cow fa-xl" },
  { name: "Condiments", icon: "fa-solid fa-jar fa-xl" },
  { name: "Beverages", icon: "fa-solid fa-coffee fa-xl" },
  { name: "Leftovers", icon: "fa-solid fa-utensils fa-xl" },
  { name: "Oils", icon: "fa-solid fa-bottle-droplet fa-xl" },
  { name: "Spices", icon: "fa-solid fa-pepper-hot fa-xl" },
  { name: "Canned", icon: "fa-solid fa-box fa-xl" },
  { name: "Miscellaneous", icon: "fa-solid fa-question fa-lx" }
]

# This will method will either create a category or update an existing one with the icon in the categories array
categories.each do |category_data|
  # Finds the category by name or initializes a new one if it doesn't exist
  category = Category.find_or_initialize_by(name: category_data[:name])
  # Saves the icon or overwrites it if it already exists
  category.icon = category_data[:icon]
  category.save!
end
