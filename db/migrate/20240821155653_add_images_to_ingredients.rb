class AddImagesToIngredients < ActiveRecord::Migration[7.1]
  def change
    add_column :ingredients, :image_url, :string
  end
end
