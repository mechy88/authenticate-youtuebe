class SessionsController < ApplicationController
  def destroy
    logout current_user
    redirect_to root_path, notice: "You have been logged out"
  end

  def new
    @user = User.new
  end

  def create
    # raise
    if user = User.authenticate_by(login_params)
      login user
      redirect_to root_path, notice: "You have signed in successfully"
    else
      @user = User.new
      flash[:alert] = "Invalid Email or Password"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
