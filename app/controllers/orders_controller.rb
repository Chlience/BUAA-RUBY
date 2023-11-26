class OrdersController < ApplicationController
  def index
    @orders = Order.where(user: current_user)
  end

  def new
    @cart_items = CartItem.where(id: params[:cart_item_ids])
    @order = Order.new
    @order.price = @cart_items.each.sum { |cart_item| cart_item.total_price }

    redirect_to new_order_path
  end

  def create
    @cart_items = CartItem.where(id: params[:order][:cart_item_ids])

    @order = Order.new()
    @order.user = current_user
    @order.delivery_address = params[:order][:delivery_address]
    @order.delivery_phone = params[:order][:delivery_phone]
    @order.delivery_name = params[:order][:delivery_name]
    @order.price = @cart_items.each.sum { |cart_item| cart_item.total_price }
    @order.status = "已下单"
    @order.save

    @cart_items.each do |cart_item|
      @order_item = OrderItem.new()
      @order_item.order = @order
      @order_item.product_type = cart_item.product_type
      @order_item.quantity = cart_item.quantity
      @order_item.price = cart_item.quantity * cart_item.product_type.price
      @order_item.save
    end

    @cart_items.each do |cart_item|
      cart_item.destroy
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_back(fallback_location: root_path)
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
end
