class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient, optional: true
  belongs_to :recipe, optional: true
  belongs_to :shopping_list
  belongs_to :category
  validates :amount, presence: true
  validates :unit, presence: true
end
