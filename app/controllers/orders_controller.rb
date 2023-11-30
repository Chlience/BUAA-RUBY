class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy, :deliver, :settle]
  before_action :is_admin?, only: [:update, :deliver]

  def index
    @orders = Order.all
  end

  def new
    @cart_items = CartItem.where(id: params[:cart_item_ids])
    @order = Order.new
    @order.price = @cart_items.each.sum { |cart_item| cart_item.total_price }

    redirect_to new_order_path
  end

  def deliver
    @order.update(status: "待收货")
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
    status: "待发货")
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
    
    redirect_back(fallback_location: root_path, notice: "成功创建订单！")
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
    if @order.update(order_params)
      redirect_back(fallback_location: root_path, notice: "订单更新成功！")
    else
      redirect_back(fallback_location: root_path, notice: "订单更新失败！")
    end
  end

  private
    def order_params
      params.require(:order).permit(:status, :delivery_address, :delivery_phone, :delivery_name, :cart_item_ids => [])
    end

    def set_order
      @order = Order.find(params[:id])
    end

    def is_admin?
      if current_user.admin?
        return true
      else
        redirect_back(fallback_location: root_path, notice: "没有权限")
      end
    end
end
