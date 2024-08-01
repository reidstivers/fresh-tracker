class AddPantryToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :pantry, foreign_key: true
  end
end
