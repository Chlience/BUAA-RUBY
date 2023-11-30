class ProductTypeSize < ApplicationRecord
  validates :product_type, uniqueness: { scope: [:size] }
  
  belongs_to :product_type
end
