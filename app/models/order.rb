class Order < ApplicationRecord
  enum status: { 已下单: 0, 已发货: 1, 已签收: 2, 已取消: 3 }
  
  belongs_to :user
  has_many :order_items, dependent: :destroy

  def total_price
    self.order_items.each.sum { |order_item| order_item.total_price }
  end
end
