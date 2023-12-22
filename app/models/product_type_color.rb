class ProductTypeColor < ApplicationRecord
  validates :product_type, uniqueness: { scope: [:color] }
	validates :color, length: { minimum: 1, maximum: 10 }
  
  belongs_to :product_type
end
