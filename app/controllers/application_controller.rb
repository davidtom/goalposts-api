class ApplicationController < ActionController::API
  # NOTE: leaving below for reference, not need when inhereting from API
  # protect_from_forgery with: :null_session

  # In some scenarios you may want to add back some functionality provided by
  # ActionController::Base that is not present by default in ActionController::API,
  # for instance MimeResponds. This module gives you the respond_to method.
  include ActionController::MimeResponds

  before_action :authorized

  def issue_token(payload)
    JWT.encode(payload, "")
  end

  def decoded_token(payload)
    begin
      JWT.decode(payload, "")
    rescue JWT::DecodeError
      return nil
    end
  end

  def authorized
    
  end
end
