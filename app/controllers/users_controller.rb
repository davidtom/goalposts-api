class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def new
    # TODO: uncomment once sessions and current_user has been set up
    # if current_user
    #   redirect_to user_path(current_user)
    # end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Goal Posts #{@user.username}!"
      session[:user_id] = @user.id
      redirect_to home_path
    else
      flash[:danger] = @user.errors.full_messages[0]
      render "new"
    end
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to home_path
  end

  private
  
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email)
    end

end
