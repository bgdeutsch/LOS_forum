class PasswordResetsController < ApplicationController
	before_action :get_user,   only: [:edit, :update]
	before_action :check_expiration, only: [:edit, :update]
	before_action :valid_user, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to '/'
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end

  # def create_reset_digest
  # 	self.reset_token = User.new_token
  #   update_attribute(:reset_digest,  User.digest(reset_token))
  #   update_attribute(:reset_sent_at, Time.zone.now)
  # end
  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end


    def get_user
      @user = User.find_by(email: params[:email])
    end


		# Checking if the reset link has expired, and informing the user.
   	def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end

		# Password reset link is only valid for two hours.
    def password_reset_expired?
    	reset_sent_at < 2.hours.ago
    end

		# Confirms a valid user.
    def valid_user
      unless (@user && @user.activated? &&
        @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

  def edit
  end
end
