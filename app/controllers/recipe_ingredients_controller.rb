class RecipeIngredientsController < ApplicationController
  before_action :set_recipe_ingredients, only: [:index]
  before_action :set_recipe_ingredient, only: [:show, :edit]
  before_action :set_recipe, only: [:index, :show, :new, :create, :edit, :update]

  def index
  end

  def show
  end

  def new
    @recipe_ingredient = RecipeIngredient.new
  end

  def create
    @recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)
    @recipe_ingredient.recipe = @recipe
    if @recipe_ingredient.save
      redirect_to recipe_path(@recipe), notice: "Ingredient added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    recipe_ingredient = RecipeIngredient.find(params[:id])
    recipe_ingredient.recipe = @recipe
    if recipe_ingredient.update(recipe_ingredient_params)
      redirect_to recipe_path(@recipe), notice: "Recipe updated"
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

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_recipe_ingredient
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_recipe_ingredients
    @recipe_ingredients = RecipeIngredient.where(recipe_id: params[:recipe_id])
  end

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:name, :amount, :unit, :category_id)
  end
end
