class ApplicationController < ActionController::Base

  devise_group :customer_or_admin, contains: [:customer, :admin]
  before_action :authenticate_customer_or_admin!,except: [:top, :about, :index, :show]

end
