require 'rails_helper'
RSpec.describe UsersController, :type => :controller do

  it "generates a token for users signing up" do
    @user = create(:user)

    expect(@user.auth_token).to_not be_nil
  end

  it "It assigns a new token when signing up" do
    user = create(:user)
    old_token = user.auth_token
    user_params = {"email" => user.email, "password" => "secret", "format" => "json"}

    post :sign_in, user_params
    user_signed_in = User.find_by(email: user.email)
    new_token = user_signed_in.auth_token

    expect(old_token).to_not eq(new_token)
  end

  it "signs a user out by reseting their token" do
    login
    token = @user.auth_token

    get :sign_out
    user_signed_out = User.find_by(email: @user.email)

    expect(user_signed_out.auth_token).to be_nil
  end
end