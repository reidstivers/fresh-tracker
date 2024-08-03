class PantriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @pantry = Pantry.new
  end

  def create
    @pantry = Pantry.new(pantry_params)
    if @pantry.save
      current_user.update(pantry: @pantry)
      redirect to @pantry, notice: "Pantry created successfully"
    # else
    #   render alert: "Pantry creation failed"
    end
  end

  def show
    # Showing current user's pantry, with collection of ingredients
    @pantry = current_user.pantry
    @ingredients = @pantry.ingredients.select { |ingredient| ingredient.in_pantry == true }
    @ingredient = Ingredient.new
  end

  private

  def pantry_params
    params.require(:pantry).permit(:user_id)
  end

end
