class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]
  before_action :authorize, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    user_params = params().require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Thanks for signing up!'
    else
      flash.now[:alert] = 'Please fix errors!'
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    user_params = params().require(:user).permit(:first_name, :last_name, :email)
    @user = User.find params[:id]
    if @user.update user_params
      redirect_to root_path, notice: 'User information updated!'
    else
      flash.now[:alert] = 'Please fix errors!'
      render :edit
    end
  end

  def password
    user_params = params.permit(:password, :password_confirmation)
    old = params[:old_password]
    @user = User.find params[:user_id]
    if !@user&.authenticate(old)
      flash[:modal] = true
      @user.errors.add(:password, 'incorrect - not authorized')
      render :edit
    elsif old == user_params[:password] && old == user_params[:password_confirmation]
      flash[:modal] = true
      @user.errors.add(:password, 'should be different from old password')
      render :edit
    elsif @user.update user_params
      redirect_to edit_user_path(@user), notice: 'Password updated!'
    else
      flash.now[:alert] = 'Please fix errors!'
      flash[:modal] = true
      render :edit
    end
  end

  private
  def set_user
    @user = User.find params[:id]
  end

  def authorize
    if !can? :manage, @user
      redirect_to root_path, alert: 'Not authorized!'
    end
  end
end
