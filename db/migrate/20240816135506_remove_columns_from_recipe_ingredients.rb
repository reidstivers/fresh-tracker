class RemoveColumnsFromRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    remove_reference :recipe_ingredients, :shopping_list, foreign_key: true, index: false
    remove_reference :recipe_ingredients, :ingredient, foreign_key: true, index: false
  end
end
