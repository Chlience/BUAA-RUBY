class PagesController < ApplicationController
  before_action :authenticate_user!

  def main
    @products = Product.all
  end
  
  def cart
    @cart_items = CartItem.where(user: current_user)
    @order = Order.new
  end

  def mine
  end

  def orders
    @orders = Order.where(user: current_user)
  end

  def favorites
    @favorites = Favorite.where(favorite_user: current_user)
  end
end
