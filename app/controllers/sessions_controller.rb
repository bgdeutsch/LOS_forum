class SessionsController < ApplicationController

  def new
  end

  def create
   user = User.find_by(email: params[:session][:email].downcase)
   if user && user.authenticate(params[:session][:password])
     if user.activated?
       log_in user
       params[:session][:remember_me] == '1' ? remember(user) : forget(user)
       redirect_to '/'
     else
       message  = "Account not activated - Check your email for details "
       flash[:warning] = message
       redirect_to '/'
     end
   else
     flash.now[:danger] = 'Invalid email/password combination'
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
