class ApplicationController < ActionController::API
  # NOTE: leaving below for reference, not need when inhereting from API
  # protect_from_forgery with: :null_session

  # In some scenarios you may want to add back some functionality provided by
  # ActionController::Base that is not present by default in ActionController::API,
  # for instance MimeResponds. This module gives you the respond_to method.
  include ActionController::MimeResponds
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authorized

  def issue_token(payload)
    JWT.encode(payload, ENV["JWT_SECRET"], ENV["JWT_ALGORITHM"])
  end

  def decode_token(payload)
    begin
      JWT.decode(payload, ENV["JWT_SECRET"], ENV["JWT_ALGORITHM"])
    rescue JWT::DecodeError
      return nil
    end
  end

  def current_user
    # pull jwt token out of request.headers (assumed to be in format: {Authorization: "Token token=xxx"})
    authenticate_or_request_with_http_token do |jwt_token, options|
      decoded_token = decode_token(jwt_token)
      # if a decoded token is found, use it to return a user
      if decoded_token
        user_id = decoded_token[0]["user_id"]
        @current_user ||= User.find_by(id: user_id)
      else
      # if no token is found, return nil so that logged_in? return false
        nil
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    # Respond with error message unless user is logged in
    render json: {message: "Access denied: not authorized."}, status: 401 unless logged_in?
  end
end
