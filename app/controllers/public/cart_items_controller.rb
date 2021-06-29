class Public::CartItemsController < ApplicationController
  def index
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items
    @total_payment = 0
    @cart_items.each do |cart_item|
    @total_payment +=(cart_item.item.price* 1.1).round*(cart_item.amount)
    end
  end
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to public_cart_items_path
  end
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item_old = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
    if @cart_item_old != nil
      new_amount = @cart_item_old.amount + @cart_item.amount
      @cart_item_old.update(amount: new_amount)
    else
      @cart_item.save
    end
    # @cart_item.item_id = params[:item_id]
    # @cart_item.amount = params[:amount]
    redirect_to public_cart_items_path
  end
  private
  def cart_item_params
   params.require(:cart_item).permit(:item_id, :amount)
   # (item_params)とアクションの後ろにつけることでrequireのpermit(カラム)を変更したりできる
  end
end
