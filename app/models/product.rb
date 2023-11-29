class Product < ApplicationRecord
  has_many :product_types, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
