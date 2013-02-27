class Verifier < ActionMailer::Base
  default :from => 'support@lovebnb.com'

  def verify(user)
    @user = user
    @url = verify_registration_path(user.email_validation_token!.guid) 
    mail(:to => user.email, :subject => "Lovebnb - Verify your email address now")
  end

end
