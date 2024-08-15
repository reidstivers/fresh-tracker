class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.favorited = true
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipes_path, notice: "Recipe added successfully"
    else
      render :index
    end
  end

  def add_ingredients
    @recipe_ingredient = Ingredient.new(ingredient_params)
    # @ingredient.pantry = current_user.pantry
    @recipe_ingredient.in_pantry = false
    @recipe_ingredient.status = 2
    if @recipe_ingredient.save
      redirect_to recipe_path(@recipe), notice: "Item added successfully"
    else
      render :add_ingredients, status: :unprocessable_entity
    end

  end

  def update
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: "Recipe deleted"
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :description)
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :amount, :unit, :category_id, :status)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
    @recipe_ingredients = Ingredient.find_by(recipe_id: current_user.recipe_ids)
  end
end
