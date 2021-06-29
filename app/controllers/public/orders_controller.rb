class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  def information
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.payment_method = params[:order][:payment_methods]
    p @order
    if params[:order][:code] == "0"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:code] == "1"
      customer_address = Address.find(params[:order][:address_code].to_i)
      @order.address = customer_address.address
      @order.postal_code = customer_address.postal_code
      @order.name = customer_address.name
    end
    @order.shipping_cost = 800
    @total_payment = 0
    @cart_items.each do |cart_item|
    @total_payment +=(cart_item.item.price* 1.1).round*(cart_item.amount)
    end
    @order.total_payment = @order.shipping_cost + @total_payment
  end
  def complete
  end
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0
    @order.shipping_cost = 800
    @order.save
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = (cart_item.item.price* 1.1).round*(cart_item.amount)
      @order_detail.save
    end
    @cart_items.destroy_all
    redirect_to public_orders_complete_path
  end
  def index
    @orders = current_customer.orders
  end
  def show
    if params[:id] != "information"
      @order = Order.find(params[:id])
    else
      redirect_to public_root_path
    end
  end
  private
  def order_params
    params.require(:order).permit(:address, :total_payment, :status, :postal_code, :name, :payment_method)
    # (address_params)とアクションの後ろにつけることでrequireのpermit(カラム)を変更したりできる
  end
end
