class Admin::OrdersController < ApplicationController
  def index

    if params[:search] != nil
      @orders = Order.where(customer_id: params[:search]).page(params[:page])
      @customer =  Customer.find(params[:search]).name_display + "さんの"
    else
      @orders = Order.page(params[:page])
      @customer = ""
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
