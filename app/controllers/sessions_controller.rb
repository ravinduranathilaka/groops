class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    # renders login form
  end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to tasks_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid username or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out successfully."
  end
end
