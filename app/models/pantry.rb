class Pantry < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_one :shopping_list, dependent: :destroy
end
