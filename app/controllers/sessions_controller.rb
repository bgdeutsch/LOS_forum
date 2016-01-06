class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log in, remember, and redirect the user to their profile.
      log_in user
      # If the user has checked the 'remember me' option when logging in,
      # call remember(user) to create a persistent session.
      # Else, call forget(user).
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to posts_path
    else
      flash.now[:danger] = 'Sorry, you have entered an invalid email/password combination.'
      render 'new'
    end
  end



  def destroy
    # Only allows a user to log out if they are logged in already,
    # eliminating an error if user happens to have the app open on multiple windows.
    log_out if logged_in?
    redirect_to '/login'
  end
end
