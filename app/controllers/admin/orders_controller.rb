class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index

    if params[:search] != nil
      @orders = Order.where(customer_id: params[:search]).order(created_at: "DESC").page(params[:page])
      @customer =  Customer.find(params[:search]).name_display + "さんの"
    else
      @orders = Order.all.order(created_at: "DESC").page(params[:page])
      @customer = ""
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)

    puts params[:order][:status]

    if params[:order][:status] == Order.statuses.key(1)
      order.order_details.each do |order_detail|
        order_detail.making_status = OrderDetail.making_statuses.key(1)
        order_detail.save
      end
    end
    redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
