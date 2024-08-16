class SearchesController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def search
    searchtext = params[:searchtext]
    result = call_recipe_api(searchtext)
    @result = result.body
    redirect_to search_recipes_path, object: @result
  end

  private

  def call_recipe_api(searchtext)
    api_key = "366c677f86864f2d9572525677095612"
    uri = URI.parse("https://api.spoonacular.com/recipes/findByIngredients?apiKey=#{api_key}&ingredients=#{searchtext}&number=10")
    # headers = { "Content-Type" => "application/json" }
    Net::HTTP.get_response(uri)

    # uri = URI.parse("https://api.spoonacular.com/recipes/findByIngredients?apiKey=#{api_key}&ingredients=apples,+flour,+sugar&number=10")
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = uri.scheme === "https"

    # headers = { "Content-Type" => "application/json" }
    # @response = http.get(uri.path, headers)
  end
end
