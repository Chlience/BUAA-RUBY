class PagesController < ApplicationController
  before_action :authenticate_user!

  def main
    @products = Product.all
  end
  
  def cart
    @cart_items = CartItem.where(user: current_user).order(created_at: :desc)
    @order = Order.new
  end

  def mine
  end

  def orders
    @orders = Order.where(user: current_user).order(created_at: :desc)
  end

  def wait_delivery_orders
    @orders = Order.where(user: current_user, status: "待发货").order(created_at: :desc)
    render "orders"
  end

  def wait_settle_orders
    @orders = Order.where(user: current_user, status: "待收货").order(created_at: :desc)
    render "orders"
  end

  def finished_orders
    @orders = Order.where(user: current_user, status: "已完成").order(created_at: :desc)
    render "orders"
  end

  def favorites
    @favorites = Favorite.where(favorite_user: current_user)
  end
end
