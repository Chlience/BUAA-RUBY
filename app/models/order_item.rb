class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product_type

  def total_price
    self.quantity * self.product_type.price
  end
end
