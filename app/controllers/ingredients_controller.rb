class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit, :update, :index, :create]
  before_action :set_ingredients, only: [:index, :create, :update]
  before_action :set_expiring, only: [:expiring, :index]
  before_action :set_image_results, only: [:results, :destroy_results, :confirm_results]

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

  # Method to display api results before placing in either pantry or shopping list
  def results
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
    status = @ingredient.status
    @ingredient.destroy
    if status == "in_pantry"
      redirect_to ingredients_path, notice: "Ingredient removed"
    elsif status == "in_cart"
      redirect_to shopping_list_path, notice: "Ingredient removed"
    elsif status == "pending"
      redirect_to results_ingredients_path, notice: "Ingredient removed"
    end
  end

  def destroy_results
    @results.each { |result| result.destroy }
    redirect_to ingredients_path, notice: "Results removed"
  end

  def confirm_results
    @results.each do |result|
      result.update(status: 0)
    end
    redirect_to ingredients_path, notice: "Ingredients added to pantry"
  end

  private

  def set_image_results
    @results = current_user.pantry.ingredients.pending
  end

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
