class ProductTypeSize < ApplicationRecord
  validates :product_type, uniqueness: { scope: [:size] }
	validates :size, length: { minimum: 1, maximum: 10 }
  
  belongs_to :product_type
end
