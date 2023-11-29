class ProductTypesController < ApplicationController
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
end
