# This allows defined stuff here to be accessed by other controllers
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_user
    Current.user ||= authenticate_user_from_session
  end
  helper_method :current_user

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout(user)
    Current.user = user
    reset_session
  end
end

# TODO: What is 'helper_method'
# TODO: Where do these functions reset_session come from?
