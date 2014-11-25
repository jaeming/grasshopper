class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token
  http_basic_authenticate_with name: "admin", password: "secret", except: [:index, :show]

  respond_to :json

  private

  # Error responses and before_filter blocking work differently with Javascript requests.
  # Rather than using before_filters to authenticate actions, we suggest using
  # "guard clauses" like `permission_denied_error unless condition`
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

end
