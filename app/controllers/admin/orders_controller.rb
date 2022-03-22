class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:customer_id] != nil
      @orders = Order.where(customer_id: params[:customer_id]).order(created_at: "DESC").page(params[:page])
      @heading =  "#{Customer.find(params[:customer_id]).name_display}さんの注文履歴"
    elsif params[:status] != nil
      @orders = Order.where(status: params[:status]).order(created_at: "DESC").page(params[:page])
      @heading = "「#{Order.statuses_i18n[params[:status]]}」の注文履歴"
    else
      @orders = Order.all.order(created_at: "DESC").page(params[:page])
      @heading = "注文履歴詳細"
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
