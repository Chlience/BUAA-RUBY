class Product < ApplicationRecord
  has_many :product_types, dependent: :destroy
end
