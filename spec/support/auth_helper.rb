module AuthHelper
  def http_login
    user = 'admin'
    pw = 'secret'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end
end
