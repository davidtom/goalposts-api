class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: {"message": @user.errors.full_messages}
    end
  end

  def current_user
    render json: current_user
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
