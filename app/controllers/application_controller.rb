class ApplicationController < ActionController::Base
  include ActionView::Layouts
  layout :theme_layout
  before_action :require_login
  skip_before_action :require_login, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  def theme_layout
    return 'application' unless current_user.present?  
    if current_user.Admin?
      'admin'
    elsif current_user.Merchant?
      'merchant'
    end
  end

  def require_login
    return true if current_user.present?
    flash[:alert] = "You must be logged in to get access"
    redirect_to user_session_path
  end
end
