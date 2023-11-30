class ProductTypeColor < ApplicationRecord
  validates :product_type, uniqueness: { scope: [:color] }
  
  belongs_to :product_type
end
