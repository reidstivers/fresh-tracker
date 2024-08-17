class RemoveOpenApiModels < ActiveRecord::Migration[7.1]
  def change
    drop_table :open_food_ingredients
  end
end
