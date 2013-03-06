class ChangePassword < ActionMailer::Base
  default from: "from@example.com"

  def request_new(user)
    @user = user
    @url = edit_password_url(user.create_forgot_password_token.guid) 
    mail(:to => user.email, :subject => "LoveBnB - change your password")
  end

end
