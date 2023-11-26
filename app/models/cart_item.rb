class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product_type

  def total_price
    self.quantity * self.product_type.price
  end
end
