class RecipeIngredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :recipe_ingredients
  belongs_to :category
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :amount, presence: true
  validates :unit, presence: true
  validates :category_id, presence: true
end
