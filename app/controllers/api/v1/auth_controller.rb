class Api::V1::AuthController < Api::V1::BaseController
  skip_before_action :authorized, only: [:create]

  def create
    # Search for user by username
    user = User.find_by(username: params[:user][:username])
    # Issue user a token if they are successfully authenticated
    if user && user.authenticate(params[:user][:password])
      payload = {user_id: user.id}
      token = issue_token(payload)
      render json: {jwt: token}
    else
      render json: {error: "Invalid credentials."}
    end
  end

end
