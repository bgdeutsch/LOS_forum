class UsersController < ApplicationController
  # before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,     only: [:destroy]
  # before_action :logged_in_user, only: [:edit, :update]




  def index
    @users = User.all
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

    respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Profile updated successfully.' }
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
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Confirm that a user is 'logged in', for authorization purposes.
  # Anonymous users will not have the same permissions as members.
  def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to '/login'
      end
  end

  # Confirm the correct user, for authorization purposes
  # such as updating their own profile and not any other user's profile information.
  def correct_user
      @user = User.find(params[:id])
      redirect_to('/login') unless @user == current_user
  end

  # Admin users will have special permissions, such as deleting members or posts.
  def admin_user
      redirect_to('/') unless current_user.isadmin?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :avatar_url, :password, :password_confirmation, :avatar)
    end


end
