class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CanCan::ControllerAdditions

  def signed_in?
    session[:user_id] != nil
  end
  helper_method :signed_in?

  def authenticate_user
    if !signed_in?
      redirect_to new_session_path, alert: "Please sign in!"
    end
  end

  def current_user
    if signed_in?
      return User.find session[:user_id]
    end
  end
  helper_method :current_user

end
