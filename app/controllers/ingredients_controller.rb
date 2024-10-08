class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit, :update, :index, :create]
  before_action :set_ingredients, only: [:index, :create, :update]
  before_action :set_expiring, only: [:expiring, :index]

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
    if params[:query].present?
      @ingredients = @ingredients.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @ingredients = current_user.pantry.ingredients.in_pantry
    end
    respond_to do |format|
      format.text do
        render partial: 'ingredients/search_results', locals: { ingredients: @ingredients }, formats: [:html]
      end
      format.html
    end
  end

  # Method to display expiring ingredients
  def expiring
  end

  def show
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      respond_to do |format|
        format.json { render json: { status: "success", ingredient: @ingredient }, status: :ok }
        format.html { redirect_to ingredients_path, notice: "Ingredient updated" }
      end
    else
      respond_to do |format|
        format.json { render json: { status: "error", errors: @ingredient.errors.full_messages }, status: :unprocessable_entity }
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ingredient.destroy
    if @ingredient.status == 0
      redirect_to ingredients_path, notice: "Ingredient removed"
    else
      redirect_to shopping_list_path, notice: "Ingredient removed"
    end
  end

  private

  def set_expiring
    filter_expiring = current_user.pantry.ingredients.select do |ingredient|
      ingredient.expiration_date.present? &&
      ingredient.expiration_date <= (Date.today + 7) &&
      ingredient.status == "in_pantry"
    end
    @expiring = filter_expiring.sort_by { |ingredient| ingredient.expiration_date }
  end

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def set_ingredients
    @pantry = current_user.pantry || current_user.create_pantry!
    @ingredients = current_user.pantry.ingredients.in_pantry
  end

  def set_categories
    @categories = Category.all
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :amount, :unit, :expiration_date, :category_id, :in_pantry, :image_url, :pantry_id)
  end
end
