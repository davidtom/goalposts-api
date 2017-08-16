class Api::V1::UsersController < Api::V1::BaseController

  def create
    user = User.new(params)
    if user.save
      render json: user
    else
      render json: {"message": user.errors}
    end
  end
end
