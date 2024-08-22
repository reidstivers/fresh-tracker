class RecipeSearchesController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def search
    if params[:query].present?
      searchtext = params[:query].gsub(" ", ",+")
      result = call_recipe_api(searchtext)
      @results = JSON.parse(result.body)
    end
  end

  def result
    @recipe = Recipe.new
    if params[:recipe].present?
      searchid = params[:recipe]
      result = call_recipe_detail_api(searchid)
      @result = JSON.parse(result.body)
    end
  end

  private

  def call_recipe_api(searchtext)
    # API Documentation: https://spoonacular.com/food-api/docs#Search-Recipes-by-Ingredients
    api_key = "#{ENV['SPOONACULAR']}"
    uri = URI.parse("https://api.spoonacular.com/recipes/findByIngredients?apiKey=#{api_key}&ingredients=#{searchtext}&number=30")
    Net::HTTP.get_response(uri)
  end

  def call_recipe_detail_api(searchid)
    # API Documentation: https://spoonacular.com/food-api/docs#Get-Recipe-Information
    api_key = "#{ENV['SPOONACULAR']}"
    uri = URI.parse("https://api.spoonacular.com/recipes/#{searchid}/information?apiKey=#{api_key}&includeNutrition=false")
    Net::HTTP.get_response(uri)
  end
end
