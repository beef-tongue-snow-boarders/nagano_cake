class ApplicationController < ActionController::Base
  before_action :item_search
  def item_search
    @search_item = Item.ransack(params[:q])
    @results = @search_item.result
  end
end
