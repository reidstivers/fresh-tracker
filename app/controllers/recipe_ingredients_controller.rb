class RecipeIngredientsController < ApplicationController
  before_action :set_recipe_ingredients, only: [:edit]

  def edit
  end

  def update
    recipe_ingredient = RecipeIngredient.find(params[:id])
    if recipe_ingredient.update(recipe_ingredient_params)
      redirect_to recipe_path(recipe.id), notice: "Recipe updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @recipe_ingredient.destroy
    redirect_to recipes_path, notice: 'Ingredient was successfully removed.'
  end

  private

  def set_recipe_ingredients
    @recipe_ingredients = RecipeIngredient.where(recipe_id: params[:recipe_id])
  end

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:name, :amount, :unit, :category_id)
  end
end
