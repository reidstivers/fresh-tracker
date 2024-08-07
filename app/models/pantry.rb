class Pantry < ApplicationRecord
  has_many :users
  has_many :ingredients
  has_one :shopping_list
end
