require 'spec_helper'

describe SessionsController do

  describe 'password provider' do

    it 'should log in an existing user where the identity exists' do

      user = FactoryGirl.create(:user_with_identity)
      identity = user.password_identity
      
      request.env['omniauth.auth'] =  {'provider' => identity.provider, "uid" => identity.password_digest}
      
      get :create

      session[:user_id].should == user.id

    end

    it 'should create a user where the identity does not exist and no-one is logged-in' do
      
      request.env['omniauth.auth'] = {"provider" => "password", "uid" => "abcdefghi", "info" => {"email" => "steve@steve.co", "name" => "steve"}}
      
      lambda do
        get :create
      end.should change(User, :count).by(1)

      session[:user_id].should == PasswordIdentity.where(provider: "password", password_digest: "abcdefghi").first.user.id

    end


  end

  describe 'google provider' do

  end

end
