class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token
  # http_basic_authenticate_with name: "admin", password: "secret", except: [:index, :show]
  respond_to :json


  # def default_serializer_options
  #   {root: false}
  # end

  def permission_denied_error
    error(403, 'Permission Denied!')
  end

  def error(status, message = 'Something went wrong')
    response = {
      response_type: "ERROR",
      message: message
    }

    render json: response.to_json, status: status
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

end
