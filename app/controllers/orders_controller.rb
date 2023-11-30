class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :deliver, :settle]

  def index
    @orders = Order.where(user: current_user)
  end

  def new
    @cart_items = CartItem.where(id: params[:cart_item_ids])
    @order = Order.new
    @order.price = @cart_items.each.sum { |cart_item| cart_item.total_price }

    redirect_to new_order_path
  end

  def deliver
    @order.update(status: "已发货")
    redirect_back(fallback_location: root_path)
  end

  def settle
    @order.update(status: "已完成")
    redirect_back(fallback_location: root_path)
  end

  def create
    @cart_items = CartItem.where(id: params[:order][:cart_item_ids])

    @order = Order.new(user: current_user,
    delivery_address: params[:order][:delivery_address],
    delivery_phone: params[:order][:delivery_phone],
    delivery_name: params[:order][:delivery_name],
    status: "已下单")
    puts @order
    @order.save

    @cart_items.each do |cart_item|
      @order_item = OrderItem.new()
      @order_item.order = @order
      @order_item.product_type = cart_item.product_type
      @order_item.size = cart_item.size
      @order_item.color = cart_item.color
      @order_item.quantity = cart_item.quantity
      @order_item.price = cart_item.product_type.price
      @order_item.save
    end

    @cart_items.each do |cart_item|
      cart_item.destroy
    end
    
    redirect_back(fallback_location: root_path)
  end

  def edit
  end

  def destroy
    if @order.destroy!
      redirect_back(fallback_location: root_path, notice: "订单删除成功！")
    else
      redirect_back(fallback_location: root_path, notice: "订单删除失败！")
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(update_order_params)

    redirect_back(fallback_location: root_path)
  end

  private
    def order_params
      params.require(:order).permit(:status, :delivery_address, :delivery_phone, :delivery_name, :cart_item_ids => [])
    end

    def update_order_params
      params.require(:order).permit(:status)
    end

    def set_order
      @order = Order.find(params[:id])
    end
end
