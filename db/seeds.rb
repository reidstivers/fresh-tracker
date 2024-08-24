# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
puts "Destroy all users, recipes and pantries"
Recipe.destroy_all
RecipeIngredient.destroy_all
Pantry.destroy_all
User.destroy_all
Ingredient.destroy_all
ShoppingList.destroy_all
Recipe.destroy_all
RecipeIngredient.destroy_all

puts "Creating User and Pantry..."

pantry = Pantry.new
shopping_list = ShoppingList.new
pantry.shopping_list = shopping_list


# Create or find a user
User.find_or_create_by!(name: "Abby", email: 'user@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.pantry = pantry
  # Ensure the user has a pantry
end

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

puts "Creating Ingredients..."

ingredients = [
  { name: 'Tomato', amount: 3, unit: 'tomatoes', category_id: Category.find_by(name: 'Vegetables').id, expiration_date: Date.today + 7.days },
  { name: 'Milk', amount: 2, unit: 'liters', category_id: Category.find_by(name: 'Dairy').id, expiration_date: Date.today + 10.days },
  { name: 'Chicken Breasts', amount: 5, unit: 'pcs', category_id: Category.find_by(name: 'Meat').id, expiration_date: Date.today + 5.days },
  { name: 'Olive Oil', amount: 1, unit: 'bottle', category_id: Category.find_by(name: 'Oils').id, expiration_date: Date.today + 365.days },
  { name: 'Banana', amount: 12, unit: 'pcs', category_id: Category.find_by(name: 'Fruits').id, expiration_date: Date.today + 3.days }
]

ingredients.each do |ingredient_data|
  ingredient = Ingredient.find_or_initialize_by(name: ingredient_data[:name])
  ingredient.amount = ingredient_data[:amount]
  ingredient.unit = ingredient_data[:unit]
  ingredient.category_id = ingredient_data[:category_id]
  ingredient.expiration_date = ingredient_data[:expiration_date]
  ingredient.in_pantry = true
  ingredient.pantry = pantry
  ingredient.status = 0
  ingredient.save!
end

puts "Creating Shopping List Ingredients"

shopping = [
  { name: 'Lettuce', amount: 3, unit: 'heads', category_id: Category.find_by(name: 'Vegetables').id, expiration_date: Date.today + 7.days },
  { name: 'Orange Juice', amount: 2, unit: 'liters', category_id: Category.find_by(name: 'Beverages').id, expiration_date: Date.today + 10.days },
  { name: 'Steak', amount: 5, unit: 'pcs', category_id: Category.find_by(name: 'Meat').id, expiration_date: Date.today + 5.days },
  { name: 'Vegetable Oil', amount: 1, unit: 'bottle', category_id: Category.find_by(name: 'Oils').id, expiration_date: Date.today + 365.days },
  { name: 'Apple', amount: 12, unit: 'pcs', category_id: Category.find_by(name: 'Fruits').id, expiration_date: Date.today + 3.days }
]

shopping.each do |item_data|
  item = Ingredient.new(
    name: item_data[:name],
    amount: item_data[:amount],
    unit: item_data[:unit],
    category_id: item_data[:category_id],
    expiration_date: item_data[:expiration_date],
    in_pantry: true,
    pantry: pantry,
    status: 1
  )
  item.save!
end
