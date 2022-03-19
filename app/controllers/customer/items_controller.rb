class Customer::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @genres = Genre.all
    if params[:id]
      @genre = Genre.find(params[:id])
      @items = @genre.items.page(params[:page])
    else
      @items = Item.page(params[:page])
    end
  end

  def show
    @item = Item.find(params[:id])
    
    @cart_item = CartItem
    @genres = Genre.all
  end


  private

  def item_params
   params.require(:items).permit(:genre_id, :name, :introduction, :price, :image)
  end

end