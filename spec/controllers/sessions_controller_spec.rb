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

    it 'should add the identity if it does not exist but the user is logged-in' do

      user = FactoryGirl.create(:user)

      sign_in(user)    

      request.env['omniauth.auth'] = {"provider" => "password", "uid" => "abcdefghi", "info" => {"email" => "steve@steve.co", "name" => "steve"}}

      user.password_identity.should be_nil      
      
      lambda do
        get :create
      end.should change(User, :count).by(0)

      user.reload

      user.password_identity.should_not be_nil
      user.password_identity.password_digest.should == "abcdefghi"
      user.password_identity.email.should == "steve@steve.co"

    end

    context 'google identity' do

      it 'should replace the identity if one exists & the user is logged-in. The old identity should be destroyed' do

        user = FactoryGirl.create(:user)
        identity = user.add_identity_from_auth({"provider" => "google_oauth2", "uid" => "12345678", "info" => {"email" => "steve@steve.com", "name" => "steve"}})

        sign_in(user)    

        request.env['omniauth.auth'] = {"provider" => "google_oauth2", "uid" => "abcdefghi", "info" => {"email" => "steve@newemailaddress.co.uk", "name" => "steve"}}

        GoogleIdentity.exists?(identity.id).should be_true

        lambda do
          get :create
        end.should change(User, :count).by(0)

        GoogleIdentity.exists?(identity.id).should be_false

        user.reload

        user.google_identity.should_not be_nil
        user.google_identity.info["email"].should == "steve@newemailaddress.co.uk"

      end

    end

  end

  
end
