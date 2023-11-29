class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ show edit update destroy ]

  def index
    @cart_items = CartItem.where(user: current_user)
  end

  # POST /cart_items or /cart_items.json
  def create
    puts params
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.product_type_id.nil?
      redirect_back(fallback_location: root_path, notice: "请选择商品类型" )
    else
      @cart_item.user_id = current_user.id

      @old_cart_item = CartItem.find_by(product_type_id: @cart_item.product_type_id, user_id: @cart_item.user_id)

      @cart_item.attributes.each do |attribute, value|
        puts "#{attribute}: #{value}"
      end
      
      if @old_cart_item.nil?
        @old_cart_item = @cart_item
      else
        @old_cart_item.quantity += @cart_item.quantity
      end

      if @old_cart_item.save
        redirect_back(fallback_location: root_path, notice: "成功加入购物车" )
      else
        redirect_back(fallback_location: root_path, notice: "出现错误" )
      end
    end
  end

  # PATCH/PUT /cart_items/1 or /cart_items/1.json
  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to cart_item_url(@cart_item), notice: "Cart item was successfully updated." }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1 or /cart_items/1.json
  def destroy
    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to cart_items_url, notice: "Cart item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_item_params
      params.require(:cart_item).permit(:product_type_id, :size, :color, :quantity)
    end
end
