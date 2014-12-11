class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token
  # before_filter :cors_preflight_check
  # after_filter :cors_set_access_control_headers
  respond_to :json

  # def cors_set_access_control_headers
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
  #   headers['Access-Control-Max-Age'] = "1728000"
  # end

  #  def cors_preflight_check
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
  #   headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
  #   headers['Access-Control-Max-Age'] = '1728000'
  # end

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
