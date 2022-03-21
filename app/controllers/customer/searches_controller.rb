class Customer::SearchesController < ApplicationController
  def search
    @q = params[:q][:name_cont]
  end
end