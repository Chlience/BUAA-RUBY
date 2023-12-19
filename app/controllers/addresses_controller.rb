class AddressesController < ApplicationController
	before_action :authenticate_user!
	
	def create
		@address = Address.new(address_params)
		@address.user = current_user

		if @address.save
			redirect_back(fallback_location: root_path, notice: "创建地址成功" )
		else
			redirect_back(fallback_location: root_path, notice: "出现错误" )
		end
	end

	def destroy
		@address = Address.find(params[:id])
		@address.destroy
		redirect_back(fallback_location: root_path, notice: "删除地址成功" )
	end

	private
		def address_params
			params.require(:address).permit(:delivery_name, :delivery_phone, :delivery_address)
		end
end
