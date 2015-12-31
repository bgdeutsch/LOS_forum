class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])

        # log user in and redirect to the user's show page
        log_in user
        redirect_to user
        else
        # create an error message
        flash.now[:danger] = 'Sorry, you have entered an invalid email/password combination.'
        render 'new'
        end
    end

    def destroy
        log_out if logged_in?
        redirect_to '/'
    end
  
end
