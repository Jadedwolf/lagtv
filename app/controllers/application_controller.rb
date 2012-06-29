class ApplicationController < ActionController::Base

  def forem_user
    current_user
  end
  helper_method :forem_user

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => "You do not have permission to access that page"
  end

	private
    def current_user
    	@current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
    end

    helper_method :current_user
end
