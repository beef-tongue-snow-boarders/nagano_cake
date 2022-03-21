class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    if params[:order_detail][:making_status] == OrderDetail.making_statuses.key(2)
      order = Order.find(order_detail.order_id)
      order.status = Order.statuses.key(2)
      order.save
    end
    if production_complete_all?(order_detail.order_id)
      order = Order.find(order_detail.order_id)
      order.status =  Order.statuses.key(3)
      order.save
    end
    redirect_to request.referer
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

  def production_complete_all?(order_id)
    flag = true
    Order.find_by(id: order_id).order_details.each do |order_detail|
      if order_detail.making_status != OrderDetail.making_statuses.key(3)
        flag = false
        break
      end
    end
    flag
  end
end
