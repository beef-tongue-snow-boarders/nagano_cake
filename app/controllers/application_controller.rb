class ApplicationController < ActionController::Base
  devise_group :customer_or_admin, contains: [:customer, :admin]
  before_action :authenticate_customer_or_admin!,except: [:top, :about, :index, :show]
  
  before_action :item_search
  def item_search
    @search_item = Item.ransack(params[:q])
    @results = @search_item.result
  end
end
