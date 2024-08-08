class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :pantry
  has_many :recipes

  def shopping_list
    pantry.shopping_list
  end

  validates :name, presence: true
end
