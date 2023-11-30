class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :set_cart_item
  before_action :authenticate_user!

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    if @product.product_url.blank?
      @product.product_url = "https://gw.alicdn.com/bao/uploaded/i1/2508474491/O1CN014jg2pU1j2vcMOqiXq_!!2508474491-0-picasso.jpg_300x300q90.jpg_.webp"
    end
    
    respond_to do |format|
      if @product.save
        @product_type = ProductType.new(product_type_name: "默认", product_id: @product.id, price: 0)
        @product_type.save!
        @product_type_size = ProductTypeSize.new(product_type: @product_type, size: "默认")
        @product_type_size.save!
        @product_type_color = ProductTypeColor.new(product_type: @product_type, color: "默认")
        @product_type_color.save!
        
        format.html { redirect_to product_url(@product), notice: "商品创建成功！" }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "商品更新成功！" }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    if @product.destroy!
      redirect_back(fallback_location: root_path, notice: "商品删除成功！")
    else
      redirect_back(fallback_location: root_path, notice: "商品删除失败！")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def set_cart_item
      @cart_item = CartItem.new()
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:product_name, :description, :product_url)
    end
end
