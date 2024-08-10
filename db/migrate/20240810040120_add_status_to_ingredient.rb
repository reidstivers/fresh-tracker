class AddStatusToIngredient < ActiveRecord::Migration[7.1]
  def change
    add_column :ingredients, :status, :integer, null: false, default: 0
  end
end
