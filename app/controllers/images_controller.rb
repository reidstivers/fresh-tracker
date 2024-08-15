class ImagesController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  require 'mini_magick'
  require 'base64'

  def recognize
    image = params[:image]
    image_data = image.read
    @result = call_image_recognition_api(image_data)

    if @result && @result['objects']
      create_ingredients_from_api(@result['objects'])
      redirect_to ingredients_path, notice: "Ingredients added from image"
    else
      flash[:error] = "API call failed or no objects detected."
      redirect_to new_ingredient_path
    end
  end

  private

  def call_image_recognition_api(image_data)
    uri = URI('https://green-ai-planet.alexander.workers.dev/')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{ENV['BEARER_TOKEN']}"
    request['Content-Type'] = 'text/plain'

    image = MiniMagick::Image.read(image_data)
    image.format 'jpg'
    image.resize '1024x1024>'

    base64_image = Base64.strict_encode64(image.to_blob)
    request.body = base64_image

    response = http.request(request)
    JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
  rescue StandardError => e
    Rails.logger.error "API call failed: #{e.message}"
    nil
  end

  def create_ingredients_from_api(objects)
    pantry = current_user.pantry
    objects.each do |object|
      Ingredient.create(
        name: object['item'],
        amount: object['qty'],
        unit: object['unit'],
        expiration_date: object['expiration_date'],
        category: Category.find_by(name: object['category']),
        pantry: pantry,
        in_pantry: true,
        status: 0
      )
    end
  end
end
