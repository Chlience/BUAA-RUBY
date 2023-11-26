class FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[ delete ]

  def index
    @favorites = Favorite.where(user_id: current_user.id)
  end

  # POST /favorites or /favorites.json
  def create
    # params 一定要传递 product_id
    # 只有在商品页面才能 create
    current_user.star(Product.find(params[:product_id]))
    redirect_back(fallback_location: root_path)
  end

  def destroy
    # params 一定要传递 product_id
    # 只有在商品页面才能 destroy
    current_user.unstar(Product.find(params[:product_id]))
    redirect_back(fallback_location: root_path)
  end

  def delete
    # 直接删除收藏
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end
end
