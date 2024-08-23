class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :category
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :amount, presence: true
  validates :unit, presence: true
  validates :category_id, presence: true

  def self.to_ingredients(current_user)
    all.map do |recipe_ingredient|
      ingredient = Ingredient.new(
        name: recipe_ingredient.name,
        amount: recipe_ingredient.amount,
        expiration_date: Date.today,
        unit: recipe_ingredient.unit,
        category_id: recipe_ingredient.category_id,
        pantry_id: current_user.pantry_id,
        in_pantry: true,
        status: "in_cart"
      )

      ingredient

    end
  end
end
