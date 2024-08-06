class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :pantry, optional: true
  has_one :shopping_list, dependent: :destroy
  after_create :create_shopping_list
  validates :name, presence: true

private
  def create_shopping_list
    self.create_shopping_list!
  end
end
