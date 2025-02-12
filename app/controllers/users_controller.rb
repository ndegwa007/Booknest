class UsersController < ApplicationController
  # show the registration form
  def new
    @user = User.new
  end
  #create a new user
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "User created successfully"
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
