class AddNullToRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    change_column_null :recipe_ingredients, :ingredient_id, true
    change_column_null :recipe_ingredients, :shopping_list_id, true
  end
end
