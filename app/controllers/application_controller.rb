class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :set_layout

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => "Você não tem permissão para acessar esta página."
  end

  private

  def set_layout
    devise_controller? ? 'devise' : 'application'
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
