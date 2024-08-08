class AddShoppingCartPantryLink < ActiveRecord::Migration[7.1]
  def change
    remove_reference :shopping_lists, :user, foreign_key: true
    add_reference :shopping_lists, :pantry, foreign_key: true
  end
end
