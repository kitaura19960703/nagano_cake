class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    redirect_to admin_order_path(@order_detail.order)
    @order = @order_detail.order
    if @order_detail.making_status == '制作中'
      # @order_details.each do |order_details|
        @order.update(status:'制作中')
      # end
    end
  end
  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  #   # (item_params)とアクションの後ろにつけることでrequireのpermit(カラム)を変更したりできる
  end
end
