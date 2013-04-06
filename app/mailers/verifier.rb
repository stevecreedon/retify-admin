class Verifier < ActionMailer::Base
  default :from => 'support@lovebnb.com'

  def verify(identity)
    @identity = identity
    @url = verify_registration_url(identity.create_validate_email_token.guid) 
    mail(:to => identity.email, :subject => "Lovebnb - Verify your email address now")
  end

end
