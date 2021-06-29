class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end
  def show
    @customer = Customer.find(params[:id])
    @new_customer = Customer.new
  end
  def edit
    # @customer = current_customer
    @customer = Customer.find(params[:id])
  end
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      render action: :edit
    end
  end
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_code, :email)
    # (item_params)とアクションの後ろにつけることでrequireのpermit(カラム)を変更したりできる
  end
end
