class Ingredient < ApplicationRecord
  belongs_to :pantry
  belongs_to :category
  has_many :recipe_ingredients
  validates :name, presence: true
  validates :category_id, presence: true
  validates :in_pantry, presence: true
  #validates :expiration_date, presence: true
  enum status: { in_pantry: 0, in_cart: 1}
end
