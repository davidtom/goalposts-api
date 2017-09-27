class Api::V1::AuthController < Api::V1::BaseController
  skip_before_action :authorized, only: [:create]

  def create
    # Search for user by username
    user = User.find_by(username: params[:username])
    # Issue user a token if they are successfully authenticated
    if user && user.authenticate(params[:password])
      payload = {user_id: user.id}
      token = issue_token(payload)
      render json: {jwt: token, user: {username: user.username, admin: user.admin}}
    else
      render json: {error: "Invalid credentials."}
    end
  end

  def show
    # if application_controller#authorized is successful, return data for user
    render json: {
      username: current_user.username,
      admin: current_user.admin
    }
  end

end
