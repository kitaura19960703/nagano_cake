class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)
    @order_details = @order.order_details
    if @order.status == '入金確認'
      @order_details.each do |order_details|
        order_details.update(making_status:1)
      end
    end
  end
  private
  def order_params
    params.require(:order).permit(:status)
  #   # (item_params)とアクションの後ろにつけることでrequireのpermit(カラム)を変更したりできる
  end
end
