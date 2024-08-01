class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.references :pantry, null: false, foreign_key: true
      t.float :amount
      t.string :unit
      t.date :expiration_date
      t.string :category
      t.boolean :in_pantry

      t.timestamps
    end
  end
end
