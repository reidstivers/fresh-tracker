class Ingredient < ApplicationRecord
  belongs_to :pantry
  belongs_to :category
  has_many :recipe_ingredients
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :category_id, presence: true
  validates :amount, presence: true
  validates :expiration_date, presence: true
  validates :in_pantry, presence: true
  enum status: { in_pantry: 0, in_cart: 1 }
  before_save :update_image_url, if: :name_changed?

  private
  # These methods add the image_url and are present in the model so they will apply to create, update, and creation via image

  def update_image_url
    return unless name.present?

    spoon_image = ingredient_api(name)
    parsed = JSON.parse(spoon_image.body)
    if parsed.length == 1
      self.image_url = "https://img.spoonacular.com/ingredients_100x100/#{parsed.first['image']}"
    else
      self.image_url = ""
    end
  end

  def ingredient_api(ingredient_name)
    api_key = ENV['SPOONACULAR']
    uri = URI.parse("https://api.spoonacular.com/food/ingredients/autocomplete?apiKey=#{api_key}&query=#{ingredient_name}&number=1")
    Net::HTTP.get_response(uri)
  end

  def in_pantry?
    status == 0  # Assuming 0 is the status for pantry items
  end
end
