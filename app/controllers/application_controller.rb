class ApplicationController < ActionController::Base

  # defines that the method current_user will be used also in the views
  helper_method :current_user, :is_admin?

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def is_admin?
    if current_user != nil
      redirect_back(fallback_location: root_path, notice: 'You do not have the privilege to perform this action.') if current_user.admin != true
    end
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice: 'you should be signed in' if current_user.nil?
  end
end
