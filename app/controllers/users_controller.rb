class UsersController < ApiController
  respond_to :json
  before_action :authenticate, only: [:show_current_user, :sign_out]

  def new
    @user = User.new
    respond_with @user
  end

  def create
    @user = User.create(user_params)
    respond_with @user
  end

  def show_current_user
    if @user
    render status: 200, json:
    {success: "true", message: "You are signed in", email: @user.email, name: @user.name, id: @user.id}
    else
      render json: {success: "false", message: "Sign in / Sign up"}
    end
  end

  def sign_in
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      user.set_auth_token
      user.save!
      render json: user
    else
      permission_denied_error
    end
  end

  def sign_out
    @user.auth_token = nil
    @user.save!
    render json: {success: "true", message: "Signed out"}
  end

  private

    def user_params
      params.permit(:email, :password, :password_confirmation, :name)
    end

    # def set_auth_token
    #   user = User.find_by_email(params[:email])
    #   return if user.auth_token.present?
    #   generate_auth_token
    # end

    # def generate_auth_token
    #   SecureRandom.uuid.gsub(/\-/,'')
    # end

end
