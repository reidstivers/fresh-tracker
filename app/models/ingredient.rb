class Ingredient < ApplicationRecord
  belongs_to :pantry
  belongs_to :category
  has_many :recipe_ingredients
  validates :name, presence: true
  validates :category_id, presence: true
  validates :in_pantry, presence: true
end
