module SessionsHelper

    # Log in method for users.
    def log_in(user)
        session[:user_id] = user.id 
    end

    # Method to retrieve logged in user throughout the app.
    def current_user
        if @current_user.nil?
            @current_user = User.find_by(id: session[:user_id])
        else
            @current_user
        end
    end

    # Returns true if the user is logged in, false otherwise.
    # Method can be used to display different links if the user is currently logged in or not.
    def logged_in?
        !current_user.nil?
    end


    # 'Logging out' the user by destroying their session.
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

end

