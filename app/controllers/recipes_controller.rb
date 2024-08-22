class RecipesController < ApplicationController
  before_action :set_recipes, only: [:index]
  before_action :set_recipe, only: [:show, :edit]
  def index
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
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    recipe = Recipe.find(params[:id])
    # if recipe.favorited == 0
    #   recipe.favorited = false
    # else
    #   recipe.favorited = true
    # end

    if recipe.update(recipe_params)
      redirect_to recipe_path(recipe.id), notice: "Recipe updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_recipes
    @recipes = Recipe.all
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
    @recipe_ingredients = RecipeIngredient.where(recipe_id: params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :image_url)
    # params.require(:recipe).permit(:title, :description, :image_url, :favorited)
  end
end
