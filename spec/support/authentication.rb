
def sign_in(user=FactoryGirl.create(:user_with_identity))
  session[:user_id] = user.id
end

def current_user
  User.where(id: session[:user_id]).first!
end

def sign_out
  session.delete(:user_id)
end


