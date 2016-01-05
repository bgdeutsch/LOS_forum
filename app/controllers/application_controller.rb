class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # include SessionsHelper to make them available across all controllers.
  include SessionsHelper

  # Confirm that a user is 'logged in', for authorization purposes.
  # Anonymous users will not have the same permissions as members.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to '/login'
    end
  end

end
