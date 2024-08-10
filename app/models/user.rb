class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # pantry MUST be optional, else it can't create the very first user!!!!! Do not delete
  belongs_to :pantry, optional: true
  has_many :recipes

  def shopping_list
    pantry.shopping_list
  end

  validates :name, presence: true
end
