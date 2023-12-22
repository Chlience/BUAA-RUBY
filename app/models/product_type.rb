class ProductType < ApplicationRecord
  validates :product_type_name, length: { minimum: 1, maximum: 20 }
  belongs_to :product

  has_many :product_type_colors, dependent: :destroy
  has_many :product_type_sizes, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
end
