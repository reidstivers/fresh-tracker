require 'fuzzy_match'
require 'levenshtein'

class RecipeIngredientsController < ApplicationController
  before_action :set_recipe, only: [:index, :show, :new, :create, :edit, :update, :to_ingredients]
  before_action :set_recipe_ingredient, only: [:show, :edit, :update, :destroy]

  def index
    @recipe_ingredients = @recipe.recipe_ingredients
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

  def to_ingredients
    Rails.logger.info "to_ingredients action triggered for recipe_id: #{@recipe.id}"
    ingredient_attributes = @recipe.recipe_ingredients.to_ingredients

    new_ingredients = ingredient_attributes.reject do |attr|
      current_user.pantry.ingredients.where(status: [0, 1], name: attr[:name]).exists?
    end

    missing_items = add_missing_items(new_ingredients, current_user.pantry.ingredients.pluck(:name))
    new_ingredients = new_ingredients.select { |ingredient| missing_items.include?(ingredient[:name]) }

    Rails.logger.info "new_ingredients: #{new_ingredients}"

    if new_ingredients.empty?
      redirect_to recipe_path(@recipe), notice: "Everything is already in your shopping list or pantry!"
    else
      new_ingredients.each do |attr|
        ingredient = current_user.pantry.ingredients.new(
          attr.merge(
            status: 1,
            expiration_date: 1.month.from_now,
            in_pantry: true
          )
        )
        if ingredient.save
          Rails.logger.info "Ingredient #{ingredient.name} added to shopping list."
        else
          Rails.logger.error "Failed to add ingredient #{ingredient.name} to shopping list: #{ingredient.errors.full_messages.join(", ")}"
        end
      end
      redirect_to recipe_path(@recipe), notice: "Added missing items to shopping list!"
    end
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

  def add_missing_items(recipe_items, shopping_list)
    fz = FuzzyMatch.new(shopping_list, read: :downcase)

    missing_items = []

    recipe_items.each do |item|
      match = fz.find(item[:name].downcase) do |rule|
        rule.threshold = 0.9
        rule.must_match_at_least_one_word = true
        rule.must_match_words = 1
      end

      if match.nil? || !similar_enough?(item[:name], match)
        missing_items << item[:name]
      end
    end

    missing_items
  end

  def similar_enough?(item1, item2)
    # Remove common plural endings
    singular1 = item1.downcase.gsub(/s$|es$|ies$/, '')
    singular2 = item2.downcase.gsub(/s$|es$|ies$/, '')

    # Check if the singular forms are the same
    return true if singular1 == singular2

    # Calculate Levenshtein distance
    distance = Levenshtein.distance(singular1, singular2)
    max_length = [singular1.length, singular2.length].max

    # Allow small differences for longer words
    return distance <= 1 if max_length > 5
    return distance == 0
  end
end
