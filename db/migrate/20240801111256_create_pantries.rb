class CreatePantries < ActiveRecord::Migration[7.1]
  def change
    create_table :pantries do |t|

      t.timestamps
    end
  end
end
