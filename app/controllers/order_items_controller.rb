class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_item, only: [:destroy]

  def destroy
    if @order_item.destroy!
      redirect_back(fallback_location: root_path, notice: "订单项删除成功！")
    else
      redirect_back(fallback_location: root_path, notice: "订单项删除失败！")
    end
  end

  private
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end
end
