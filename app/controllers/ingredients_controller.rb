class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit, :update, :index, :create]
  before_action :set_ingredients, only: [:index, :create, :update]

  def new
    @ingredient = Ingredient.new
  end

  def create
    @pantry = current_user.pantry
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.pantry = @pantry
    @ingredient.in_pantry = true

    if @ingredient.save
      redirect_to ingredients_path, notice: "Ingredient saved"
    else
      render :index, status: :unprocessable_entity
    end
  end

  def index
    @ingredient = Ingredient.new
    @ingredients = Ingredient.all
    if params[:query].present?
      @ingredients = @ingredients.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def show
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to ingredients_path, notice: "Ingredient updated"
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def set_ingredients
    @ingredients = current_user.pantry.ingredients
  end

  def set_categories
    @categories = Category.all
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :amount, :unit, :expiration_date, :category_id, :in_pantry, :pantry_id)
  end
end
