class AddCategorytoIngredients < ActiveRecord::Migration[7.1]
  def change
    add_reference :ingredients, :category, null: false, foreign_key: true
  end
end
