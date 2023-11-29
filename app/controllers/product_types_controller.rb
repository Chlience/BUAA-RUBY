class ProductTypesController < ApplicationController
  before_action :set_product_type, only: [:destroy]
  before_action :set_product, only: [:new]

  def new
    @product_type = ProductType.new
  end
  
  def create
    # TODO
  end
  
  def destroy
    puts @product_type.product_type_name
    redirect_back(fallback_location: root_path)
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
end
