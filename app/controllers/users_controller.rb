class UsersController < ApiController
  respond_to :json

  def new
    @user = User.new
    respond_with @user
  end

  def create
    @user = User.create(user_params)
    respond_with @user
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :name)
  end

end
