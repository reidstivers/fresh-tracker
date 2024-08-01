class Ingredient < ApplicationRecord
  belongs_to :pantry
  has_many :recipe_ingredients
  validates :name, presence: true
  validates :category, presence: true
  validates :in_pantry, presence: true
end
