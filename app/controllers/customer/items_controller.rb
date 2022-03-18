class Customer::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end

  private

  def item_params
   params.require(:items).permit(:genre_id, :name, :introduction, :price, :image)
  end

end
