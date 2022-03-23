class Customer::CartItemsController < ApplicationController
  before_action :authenticate_customer!,except: [:index, :show]
  def index
    @cart_items = current_customer.cart_items.all
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save
      flash.now[:notice] = "カートに商品を追加しました。"
      @cart_items = current_customer.cart_items.all
      render 'index'
    else
      render 'index'
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_items = current_customer.cart_items.all
    if @cart_item.update(cart_item_params)
      flash.now[:notice] = "商品の数量を変更しました。"
    end
  end

  def destroy
    @cart_items = current_customer.cart_items.all
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
  end

  def all_destroy
    @cart_items = CartItem.all
    @cart_items.destroy_all
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end
end
