module AuthHelper
  def login user=nil
    @user = user || create(:user)
    session[:user_id] = @user.id
  end
end


