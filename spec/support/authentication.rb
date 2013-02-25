
def sign_in(user=FactoryGirl.create(:user_with_identity))
  session[:user_id] = user.id
end

def current_user
  User.where(id: session[:user_id]).first!
end

def sign_out
  session.delete(:user_id)
end

def build_user(options={})
  user_opts = options[:user] || {}
  identity_opts = options[:identity] || {}
  user = FactoryGirl.build(:user, user_opts)
  identity = FactoryGirl.build(:identity, identity_opts)
  user.identities << identity
  user
end

def create_user(opts={})
  user = build_user(opts)
  user.save!
  user
end

