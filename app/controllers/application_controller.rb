class ApplicationController < ActionController::Base
  devise_group :customer_or_admin, contains: [:customer, :admin]
  before_action :authenticate_customer_or_admin!,except: [:top, :about, :index, :show, :create]

  before_action :item_search
  def item_search
    @search_item = Item.ransack(params[:q])
    @results = @search_item.result
  end

  private

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      admin_path
    else
      customers_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
      root_path
    elsif resource_or_scope == :admin
        new_admin_session_path
    else
  		  root_path
    end
  end


end
