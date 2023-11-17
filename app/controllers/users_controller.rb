class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_path, notice: 'Registered and logged in successfully!'
    else
      render 'new'
    end
  end

  def login
    # Display login form
  end

  def authenticate
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path, notice: 'Logged in successfully!'
    else
      flash.now[:danger] = user ? 'Invalid password' : 'User not found'
      render 'login'
    end
  end

  def logout
    log_out
    redirect_to root_path, notice: 'Logged out successfully!'
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end