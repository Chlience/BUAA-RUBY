class User < ApplicationRecord
  # default: 0 means that the default value of the role attribute is 0, which corresponds to the user role.
  enum role: [:user, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :favorite_products, through: :favorites

  has_many :cart_items, dependent: :destroy
  has_many :orders

  def star(product)
    favorites.create(product_id: product.id)
  end

  def unstar(product)
    favorites.find_by(product_id: product.id).destroy
  end

  def favorite?(product)
    favorite_products.include?(product)
  end
end
