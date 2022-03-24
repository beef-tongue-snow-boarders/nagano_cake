class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:customer_id] != nil && params[:status] != nil
      @orders = Order.where(customer_id: params[:customer_id], status: params[:status]).order(created_at: "DESC").page(params[:page])
      @heading = "#{Customer.find(params[:customer_id]).name_display}さんの注文履歴「#{Order.statuses_i18n[params[:status]]}」（全#{ Order.where(customer_id: params[:customer_id], status: params[:status]).count}件）"
      @customer_id = params[:customer_id]
    elsif params[:customer_id] != nil
      @orders = Order.where(customer_id: params[:customer_id]).order(created_at: "DESC").page(params[:page])
      @heading =  "#{Customer.find(params[:customer_id]).name_display}さんの注文履歴（全#{Order.where(customer_id: params[:customer_id]).count}件）"
      @customer_id = params[:customer_id]
    elsif params[:status] != nil
      @orders = Order.where(status: params[:status]).order(created_at: "DESC").page(params[:page])
      @heading = "注文履歴詳細「#{Order.statuses_i18n[params[:status]]}」（全#{Order.where(status: params[:status]).count}件）"
      @customer_id = nil
      @count_status = count_status
    else
      @orders = Order.all.order(created_at: "DESC").page(params[:page])
      @heading = "注文履歴詳細（全#{Order.all.count}件）"
      @customer_id = nil
      @count_status = count_status
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    if params[:order][:id] == nil
      @order = Order.find(params[:id])
    else
      @order = Order.find(params[:order][:id])
    end
    @order.update(order_params)
    if params[:order][:status] == Order.statuses.key(1)
      @order.order_details.each do |order_detail|
        order_detail.making_status = OrderDetail.making_statuses.key(1)
        order_detail.save
      end
    end
    # 非同期通信(jsファイルへの受け渡し:@order)
    # redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def count_status
    status_name_0 = Order.statuses_i18n[Order.statuses.key(0)]
    status_num_0 = Order.where(status: Order.statuses.key(0)).count
    status_name_1 = Order.statuses_i18n[Order.statuses.key(1)]
    status_num_1 = Order.where(status: Order.statuses.key(1)).count
    status_name_2 = Order.statuses_i18n[Order.statuses.key(2)]
    status_num_2 = Order.where(status: Order.statuses.key(2)).count
    status_name_3 = Order.statuses_i18n[Order.statuses.key(3)]
    status_num_3 = Order.where(status: Order.statuses.key(3)).count
    status_name_4 = Order.statuses_i18n[Order.statuses.key(4)]
    status_num_4 = Order.where(status: Order.statuses.key(4)).count
    "「#{status_name_0}」:#{status_num_0}件, 「#{status_name_1}」:#{status_num_1}件, 「#{status_name_2}」:#{status_num_2}件, 「#{status_name_3}」:#{status_num_3}件, 「#{status_name_4}」:#{status_num_4}件"
  end
end
