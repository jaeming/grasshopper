class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token
  respond_to :json

  protected
    def authenticate
      authenticate_token || permission_denied_error
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @user = User.find_by(auth_token: token)
      end
    end

    def permission_denied_error
      error('false', 401, 'Sign up / Sign in.')
    end

    def error(success, status, message)
      response = { success: 'false', response_type: status, message: message }
      render json: response, status: status, message: message
    end

end
