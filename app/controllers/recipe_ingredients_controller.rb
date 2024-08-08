class RecipeIngredientsController < ApplicationController
  def destroy
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @recipe_ingredient.destroy
    redirect_to shopping_lists_path, notice: 'Ingredient was successfully removed.'
  end
end
