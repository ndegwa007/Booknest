class SessionsController < ApplicationController
  # show the login form
  def new
  end

  # create a new session
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) # check if user exists and password is correct
      session[:user_id] = user.id # store user id in session
      redirect_to root_path, notice: "Logged in successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end
  # logout the user
  def destroy
    session[:user_id] = nil # clear the session
    redirect_to root_path, notice: "Logged out successfully"
  end
end
