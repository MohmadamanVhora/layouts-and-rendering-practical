class ApplicationController < ActionController::Base
  include ActionView::Layouts
  layout :theme_layout

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
end
