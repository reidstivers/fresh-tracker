class Category < ApplicationRecord
  has_many :ingredients
  has_many :recipe_ingredients

  validates :name, presence: true, uniqueness: true

  CATEGORY_MAPPING = {
    "Baking" => "Miscellaneous",
    "Health Foods" => "Miscellaneous",
    "Spices and Seasonings" => "Condiments",
    "Pasta and Rice" => "Miscellaneous",
    "Bakery/Bread" => "Miscellaneous",
    "Refrigerated" => "Miscellaneous",
    "Canned and Jarred" => "Canned",
    "Frozen" => "Canned",
    "Nut butters, Jams, and Honey" => "Condiments",
    "Oil, Vinegar, Salad Dressing" => "Oils",
    "Condiments" => "Condiments",
    "Savory Snacks" => "Miscellaneous",
    "Milk, Eggs, Other Dairy" => "Dairy",
    "Ethnic Foods" => "Miscellaneous",
    "Tea and Coffee" => "Beverages",
    "Meat" => "Meat",
    "Gourmet" => "Miscellaneous",
    "Sweet Snacks" => "Miscellaneous",
    "Gluten Free" => "Miscellaneous",
    "Alcoholic Beverages" => "Beverages",
    "Cereal" => "Miscellaneous",
    "Nuts" => "Condiments",
    "Beverages" => "Beverages",
    "Produce" => "Vegetables",
    "Not in Grocery Store/Homemade" => "Miscellaneous",
    "Seafood" => "Fish",
    "Cheese" => "Dairy",
    "Dried Fruits" => "Fruits",
    "Online" => "Miscellaneous",
    "Grilling Supplies" => "Miscellaneous",
    "Bread" => "Miscellaneous",
    nil => "Miscellaneous"
  }
end
