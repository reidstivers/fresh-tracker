class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :category
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :amount, presence: true
  validates :unit, presence: true
  validates :category_id, presence: true

  def self.to_ingredients
    all.map do |recipe_ingredient|
      {
        name: recipe_ingredient.name,
        amount: recipe_ingredient.amount,
        unit: recipe_ingredient.unit,
        category_id: recipe_ingredient.category_id
      }
    end
  end
end
