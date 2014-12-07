class UsersController < ApiController
  respond_to :json

  def new
    @user = User.new
    respond_with @user
  end

  def create
    @user = User.create(user_params)
    if(@user.save)
      session[:user_id] = @user.id
      respond_with @user
    else
      permission_denied_error
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :name)
  end

end
