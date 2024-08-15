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

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
