class ProductTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product_type, only: [:destroy, :edit, :update]
  before_action :set_product, only: [:new, :edit, :create, :update]
  before_action :is_admin?, except: %i[ colors sizes price ]

  def new
    @product_type = ProductType.new
  end

  def edit
    @product_type_size = ProductTypeSize.new
    @product_type_color = ProductTypeColor.new
  end

  def update
    @product_type.product_type_name = params[:product_type][:product_type_name]
    @product_type.price = params[:product_type][:price]
    respond_to do |format|
      if @product_type.save
        redirect_back(fallback_location: root_path, notice: "商品类型更新成功！")
      else
        redirect_back(fallback_location: root_path, notice: "商品类型更新失败！")
      end
    end
  end
  
  def create
    @product_type = ProductType.new(product_type_name: params[:product_type][:product_type_name], product_id: params[:product_id], price: params[:product_type][:price])

    respond_to do |format|
      if @product_type.save
        @product_type_size = ProductTypeSize.new
        @product_type_size.product_type = @product_type
        @product_type_size.size = "默认"
        @product_type_size.save
        @product_type_color = ProductTypeColor.new
        @product_type_color.product_type = @product_type
        @product_type_color.color = "默认"
        @product_type_color.save
        redirect_back(fallback_location: root_path, notice: "新商品类型创建成功！")
      else
        redirect_back(fallback_location: root_path, notice: "新商品类型创建失败！")
      end
    end
  end
  
  def destroy
    respond_to do |format|
      if @product_type.destroy!
        redirect_back(fallback_location: root_path, notice: "商品类型删除成功！")
      else
        redirect_back(fallback_location: root_path, notice: "商品类型删除失败！")
      end
    end
  end
  
  def colors
    colors = ProductTypeColor.where(product_type_id: params[:id]).pluck(:color).uniq
    render json: colors
  end
  
  def sizes
    sizes = ProductTypeSize.where(product_type_id: params[:id]).pluck(:size).uniq
    render json: sizes
  end
  
  def price
    price = ProductType.find(params[:id]).price
    render json: price
  end

  private 
    def set_product_type
      @product_type = ProductType.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

	  def is_admin?
      if current_user.admin?
        return true
      else
        redirect_back(fallback_location: root_path, notice: "没有权限")
      end
	  end
end
