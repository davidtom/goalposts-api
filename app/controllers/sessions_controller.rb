class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Log in successful."
      redirect_to home_path
    else
      flash[:danger] = "Incorrect login credentials."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Log out successful."
    redirect_to home_path
  end

end
