class IngredientsController < ApplicationController
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
      render "ingredients/index", notice: "Ingredient not saved"
    end
  end

  def index
    @ingredients = current_user.pantry.ingredients
    @ingredient = Ingredient.new
    @categories = Category.all
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])

    if @ingredient.update(ingredient_params)
      redirect_to @ingredient
    else
      render "pantry/show", notice: "Ingredient not updated"
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, :amount, :unit, :expiration_date, :category_id, :in_pantry, :pantry_id)
  end
end
