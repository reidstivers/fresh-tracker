class PantriesController < ApplicationController
  def show
    # Showing current user's pantry, with collection of ingredients
    @pantry = current_user.pantry
    @ingredients = @pantry.ingredients
  end
end
