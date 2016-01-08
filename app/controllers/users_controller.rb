class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,     only: [:destroy]


  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

  # # Confirm the correct user, for authorization purposes
  # # such as updating their own profile and not any other user's profile information.
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless @user == current_user
    flash.now[:warning] = 'Sorry, you are not authorized for that action.'
  end

  # Admin users will have special permissions, such as deleting members or posts.
  def admin_user
    redirect_to('/') unless current_user.isadmin?
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar_url, :password, :password_confirmation, :avatar, :description, :titles, :sackos)
  end
end
