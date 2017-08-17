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
    authenticate_or_request_with_http_token do |jwt_token, options|

      decoded_token = decode_token(jwt_token)

      if decoded_token[0]["user_id"]
        @current_user || User.find(decoded_token[0]["user_id"])
      else
      end

    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: {message: "Access denied: not authorized."}, status: 401 unless logged_in?
  end
end
