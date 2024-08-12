class ShoppingListsController < ApplicationController
  before_action :set_shopping_list, only: [:index, :create]

  def index
    #@recipe_ingredient = RecipeIngredient.new
    @ingredient = Ingredient.new
    @ingredients = current_user.pantry.ingredients.in_cart
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.pantry = current_user.pantry
    @ingredient.in_pantry = true
    @ingredient.expiration_date = Date.today + 7.days
    @ingredient.status = 1
    if @ingredient.save
      redirect_to shopping_lists_path, notice: "Item added successfully"
    else
      render :index
    end
  end

  def update
    @ingredient = Ingredient.find(params[:id])

    if params[:status].present?
      @ingredient.status = params[:status].to_i
    end

    if @ingredient.save
      redirect_to shopping_lists_path, notice: "Item updated successfully"
    else
      render :index
    end
  end

  private

  def set_shopping_list
    @shopping_list = current_user.pantry.shopping_list || current_user.pantry.create_shopping_list
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :amount, :unit, :expiration_date, :category_id, :status, :pantry_id)
  end
end
