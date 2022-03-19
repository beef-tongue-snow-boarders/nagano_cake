class Customer::HomesController < ApplicationController
  def top
    @items = Item.limit(4).order("created_at DESC")
    @genres = Genre.all
  end

  def about
  end
end
