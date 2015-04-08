class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :set_layout

  private

  def set_layout
    devise_controller? ? 'devise' : 'application'
  end

  def after_sign_in_path_for(resource)
    user_path(resource)
  end
end
