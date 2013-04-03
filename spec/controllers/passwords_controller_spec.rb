require 'spec_helper'

describe PasswordsController do

  it 'should raise a 404 if the current user has no password identity' do
  
    user = FactoryGirl.build(:user)
    user.identities << MockIdentity.new
    user.save!
    
    sign_in user
    
    lambda do 
    	get :edit
    end.should raise_error(ActionController::RoutingError)
  end

  context 'authetication' do

   context 'anonymous users' do
      
	   it 'should redirect if the user has not authenticated' do
	    get :edit
	    response.should redirect_to new_session_path 
	   end

	   it 'should allow access if the request supplies a valid token' do
	    user = FactoryGirl.create(:user_with_identity)
	    token = user.create_forgot_password_token!
	    get :edit, tid: token.guid
	    response.should be_ok 
	   end

	   it 'should render the home template if the request supplies a valid token' do
	    user = FactoryGirl.create(:user_with_identity)
	    token = user.create_forgot_password_token!
	    get :edit, tid: token.guid
	    response.should render_template('layouts/home')
	   end

	   it 'should redirect to the forgot password page if no valid token is found' do
	    user = FactoryGirl.create(:user_with_identity)
	    token = user.create_forgot_password_token!
	    Timecop.travel(Time.gm(*Time.now) + 25.hours) do
	     get :edit, tid: token.guid
	     response.should redirect_to forgot_password_path 
	    end
	   end

    it 'should allow anonymous access to the forgot password page' do
      get :forgot
      response.should be_ok      
    end

    it 'should allow anonymous access to the sent passowrd page' do
      get :sent
      response.should be_ok      
    end

    it 'should allow anonymous access to the sent passowrd page' do
      post :requested
      response.should_not redirect_to new_session_path      
    end

   end

   context 'logged-in user' do
     
     it 'should allow access if the user has signed-in' do
       user = FactoryGirl.create(:user_with_identity)
       sign_in(user)
       get :edit
      response.should be_ok
     end

     it 'should render the application template if the user has signed-in' do
       user = FactoryGirl.create(:user_with_identity)
       sign_in(user)
       get :edit
       response.should render_template('layouts/application')
     end

   end
   
  
  end

end
