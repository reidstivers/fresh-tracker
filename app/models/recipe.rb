class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true

  validates :title, presence: true
  validates :description, presence: true
  validates :favorited, presence: true
end
