class ProductTypeColorsController < ApplicationController
  before_action :set_product_type_color, only: [:destroy]

  def create
    @product_type_color = ProductTypeColor.new(product_type_id: params[:product_type_id], color: params[:product_type_color][:color])
		if @product_type_color.color.blank?
			redirect_back(fallback_location: root_path, notice: "颜色不能为空！")
    end
    if @product_type_color.save
      redirect_back(fallback_location: root_path, notice: "颜色添加成功！")
    else
      redirect_back(fallback_location: root_path, notice: "颜色添加失败！")
    end
  end

  def destroy
    if @product_type_color.destroy
      redirect_back(fallback_location: root_path, notice: "颜色删除成功！")
    else
      redirect_back(fallback_location: root_path, notice: "颜色删除失败！")
    end
  end

  private
    def set_product_type_color
      @product_type_color = ProductTypeColor.find(params[:id])
    end
    def product_type_color_params
      params.require(:product_type_color).permit(:color)
    end
end
