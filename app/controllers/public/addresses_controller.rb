class Public::AddressesController < ApplicationController
  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end
  def edit
    @address = Address.find(params[:id])
  end
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
     redirect_to public_addresses_path
    else
      @addresses = Address.all
      render action: :index
    end
  end
  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to public_addresses_path
    else
      render action: :edit
    end
  end
  def destroy
     @address = Address.find(params[:id])
    @address.destroy
    redirect_to public_addresses_path
  end
  private
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
    # (address_params)とアクションの後ろにつけることでrequireのpermit(カラム)を変更したりできる
  end
end
