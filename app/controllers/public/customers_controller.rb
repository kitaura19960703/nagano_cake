class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end
  def edit
    @customer = current_customer
  end
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to public_my_page_path
    else
      render action: :edit
    end
  end
  def unsubscribe
    # @customer = current_customer
    # @customer.
    # redirect_to public_root_path
  end
  def cancel
    @customer = current_customer
    @customer.update(is_active: false)
    # 退会機能もupdate
    reset_session
    redirect_to public_root_path
  end
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_code, :email)
    # (item_params)とアクションの後ろにつけることでrequireのpermit(カラム)を変更したりできる
  end
end
