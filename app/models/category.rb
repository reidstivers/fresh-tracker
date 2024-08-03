class Category < ApplicationRecord
  has_many :ingredients
  has_many :recipe_ingredients

  validates :name, presence: true, uniqueness: true
end
