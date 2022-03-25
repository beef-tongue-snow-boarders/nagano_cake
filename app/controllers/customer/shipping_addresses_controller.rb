class Customer::ShippingAddressesController < ApplicationController
  before_action :authenticate_customer!
  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.customer_id = current_customer.id
    if @shipping_address.save
       @shipping_address = ShippingAddress.new(shipping_address_params)
       @shipping_addresses = current_customer.shipping_addresses
       flash.now[:notice] = "配送先を登録しました。"
    else
       @shipping_addresses = current_customer.shipping_addresses
    end
  end

  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = current_customer.shipping_addresses
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      redirect_to shipping_addresses_path, notice: "配送先を変更しました。"
    else
      render 'edit'
    end
  end

  def destroy
    @shipping_addresses = current_customer.shipping_addresses
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.destroy
    flash.now[:notice] = "配送先を削除しました。"
  end


  private

  def shipping_address_params
    params.require(:shipping_address).permit(:postal_code, :address, :name)
  end

end