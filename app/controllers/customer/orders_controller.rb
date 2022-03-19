class Customer::OrdersController < ApplicationController

  before_action :ensure_cart_item, only: [:new, :order_confirm]

  def new
    @order = Order.new
  end

  def order_confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @shipping_cost = 800
    @total_price = 0
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_number] == "2"
      @order.postal_code = ShippingAddress.find(params[:order][:shipping_address_id]).postal_code
      @order.address = ShippingAddress.find(params[:order][:shipping_address_id]).address
      @order.name = ShippingAddress.find(params[:order][:shipping_address_id]).name
    elsif params[:order][:address_number] == "3"
     @order.customer_id = current_customer.id
    else
      render :new
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items = current_customer.cart_items.all
      cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.order_id = @order.id
        @order_detail.price = cart_item.item.add_tax_price
        @order_detail.amount = cart_item.amount
        @order_detail.making_status = OrderDetail.making_statuses.key(0)
        @order_detail.save
      end
      cart_items.destroy_all
      redirect_to orders_complete_path
    else
      render :new
    end
  end

  def complete
  end

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name,:shipping_cost, :total_payment, :status)
  end

  def ensure_cart_item
    cart_items = current_customer.cart_items.all
    unless cart_items.present?
      redirect_to items_path
    end
  end
end
