class SessionsController < ApiController
  respond_to :json
  skip_before_filter :verify_authenticity_token

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      puts user.email
      respond_with user
    else
      permission_denied_error
    end
  end

  def destroy
    session[:user_id] = nil
    respond_with session
  end
end