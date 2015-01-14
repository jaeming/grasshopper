module AuthHelper
  def login
    @user = create(:user)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(@user.auth_token)
  end
end