class ShoppingList < ApplicationRecord
  belongs_to :pantry
  has_many :recipe_ingredients
end
