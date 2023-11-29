class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?, only: [:manage]

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

  def manage
  end

  private
    def is_admin?
      if current_user.admin?
        return true
      else
        redirect_to root_path
      end
    end
end
