# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  protected

  def reject_user
    if @customer = Customer.find_by(email: params[:customer][:email])
      if @customer.is_active == false
        flash[:error] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_customer_session_path
      else
        flash[:error] = "項目を入力してください"
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.

end
