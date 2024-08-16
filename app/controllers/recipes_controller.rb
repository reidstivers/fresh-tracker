class RecipesController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  before_action :set_recipe, only: [:show, :edit, :destroy]
  before_action :set_new_ingredient, only: [:edit]

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

  def edit
  end

  def update
    recipe = Recipe.find(params[:id])
    if recipe.update(recipe_params)
      redirect_to recipe_path(recipe.id), notice: "Recipe updated"
    else
      render :edit, status: :unprocessable_entity
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

  def search
    @test = "recipes controller no search"
    search_ingredients = "apples,+flour,+sugar"
    @response = JSON.parse(call_recipe_apii(search_ingredients).body)
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
    @recipe_ingredients = Ingredient.where(recipe_id: params[:id])
  end

  def set_new_ingredient
    @new_ingredient = Ingredient.new
  end

  def call_recipe_apii(search_ingredients)
    api_key = "366c677f86864f2d9572525677095612"
    uri = URI.parse("https://api.spoonacular.com/recipes/findByIngredients?apiKey=#{api_key}&ingredients=#{search_ingredients}&number=10")
    # headers = { "Content-Type" => "application/json" }
    Net::HTTP.get_response(uri)

    # uri = URI.parse("https://api.spoonacular.com/recipes/findByIngredients?apiKey=#{api_key}&ingredients=apples,+flour,+sugar&number=10")
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = uri.scheme === "https"

    # headers = { "Content-Type" => "application/json" }
    # @response = http.get(uri.path, headers)
  end
end
