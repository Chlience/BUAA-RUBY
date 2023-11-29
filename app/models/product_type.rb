class ProductType < ApplicationRecord
  belongs_to :product

  has_many :product_type_colors, dependent: :destroy
  has_many :product_type_sizes, dependent: :destroy
end
