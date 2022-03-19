class ApplicationController < ActionController::Base
  devise_group :admin_or_customer, contains: [:admin, :customer]
  before_action :authenticate_admin_or_customer!,except: [:top, :about, :index, :show]

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
      current_customer
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
