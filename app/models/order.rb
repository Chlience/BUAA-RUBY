class Order < ApplicationRecord
  enum status: { 待发货: 0, 待收货: 1, 已完成: 2, 已删除: 3 }
  
  belongs_to :user
  has_many :order_items, dependent: :destroy

  def total_price
    self.order_items.each.sum { |order_item| order_item.total_price }
  end
end
