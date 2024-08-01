class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  validates :title, presence: true
  validates :description, presence: true
  validates :favorited, presence: true
end
