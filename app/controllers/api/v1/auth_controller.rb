class Api::V1::AuthController < Api::V1::BaseController

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
    else
    end
  end
end
