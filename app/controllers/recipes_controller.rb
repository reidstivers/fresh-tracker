class RecipesController < ApplicationController
  before_action :set_recipes, only: [:index]
  before_action :set_recipe, only: [:show, :edit, :update]

  def index
  end

  def show
    @recipe_ingredients = @recipe.recipe_ingredients
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
    @recipe.recipe_ingredients.build if @recipe.recipe_ingredients.empty?
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: 'Recipe was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_recipes
    @recipes = Recipe.all
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description,
      recipe_ingredients_attributes: [:id, :name, :amount, :unit, :category_id, :_destroy])
  end

  def update_recipe_ingredients
    params[:recipe_ingredients].each do |id, ingredient_params|
      ingredient = RecipeIngredient.find_or_initialize_by(id: id, recipe: @recipe)
      if ingredient_params[:_destroy] == '1'
        ingredient.destroy
      else
        ingredient.update(ingredient_params.except(:_destroy))
      end
    end
  end
end
