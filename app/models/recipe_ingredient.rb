class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe
  belongs_to :shopping_list
  validates :amount, presence: true
  validates :unit, presence: true
end
