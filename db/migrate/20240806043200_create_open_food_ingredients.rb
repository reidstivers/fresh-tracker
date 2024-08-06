class CreateOpenFoodIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :open_food_ingredients do |t|

      t.timestamps
    end
  end
end
