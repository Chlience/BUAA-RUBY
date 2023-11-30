class ProductTypeSizesController < ApplicationController
	before_action :set_product_type_size, only: [:destroy]

	def create
		@product_type_size = ProductTypeSize.new(product_type_id: params[:product_type_id], size: params[:product_type_size][:size])
		if @product_type_size.size.blank?
			redirect_back(fallback_location: root_path, notice: "尺码不能为空！")
		end
		if @product_type_size.save!
			redirect_back(fallback_location: root_path, notice: "尺码添加成功！")
		else
			redirect_back(fallback_location: root_path, notice: "尺码添加失败！")
		end
	end
  
	def destroy
	  if @product_type_size.destroy!
		redirect_back(fallback_location: root_path, notice: "尺码删除完成！")
	  else
		redirect_back(fallback_location: root_path, notice: "尺码删除失败！")
	  end
	end
  
	private
	  def set_product_type_size
		@product_type_size = ProductTypeSize.find(params[:id])
	  end

	  def product_type_size_params
		params.require(:product_type_size).permit(:size)
	  end
end
