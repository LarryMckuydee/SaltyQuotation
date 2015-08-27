class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  USER,PASSWORD = 'happyornot','happy'
  protect_from_forgery with: :exception
  # before_filter :authentication_check
  before_filter :configure_permitted_parameters, if: :devise_controller?


  protected
  def authenticate_user!
    if apparel_consultant_signed_in?
      super
    else
      redirect_to new_apparel_consultant_session, :notice => 'Please login to proceed'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) do |u|
    #   u.permit :name, :email, :password, :password_confirmation
    # end
    #
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name,:email,:password, :password_confirmation, :current_password)
    end
  end


  def authentication_check
      authenticate_or_request_with_http_basic do |user,password|
         user == USER && password == PASSWORD
      end
  end
end
