class RecipeSearchesController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def search
    if params[:query].present?
      searchtext = params[:query].tr("", ",+")
      result = call_recipe_api(searchtext)
      @results = JSON.parse(result.body)
    end
  end

  def result
    @text = "result page!"
  end

  private

  def call_recipe_api(searchtext)
    # working url
    # https://api.spoonacular.com/recipes/findByIngredients?apiKey=366c677f86864f2d9572525677095612&ingredients=apples,+flour,+sugar&number=10
    api_key = "366c677f86864f2d9572525677095612"
    uri = URI.parse("https://api.spoonacular.com/recipes/findByIngredients?apiKey=#{api_key}&ingredients=#{searchtext}&number=10")
    Net::HTTP.get_response(uri)
  end
end
