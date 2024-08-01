class ShoppingList < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
end
