class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def after_sign_up_path_for(resource)
  #   customers_customers_my_page_path
  # end

  def after_sign_up_path_for(resource)
    byebug
    case resource
    # deviseを複数作っているときはcase resourceで場合分けをする
    when Admin
      new_admin_session_path
    when Customer
      public_my_page_path
    end
  end

  def after_sign_out_path_for(resource)
    case
    #sign_outの時はdeleteメゾット機能が反映され空の状態になっているのでresource入らない
    when Admin
      new_admin_session_path
    when Customer
      public_root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_code, :password_confirmation])
  end
end