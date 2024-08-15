class AddRecipeRefToIngredients < ActiveRecord::Migration[7.1]
  def change
    add_reference :ingredients, :recipe, foreign_key: true
  end
end
