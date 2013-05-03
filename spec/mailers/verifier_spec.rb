require 'spec_helper'

describe Verifier do

  let(:user){FactoryGirl.create(:user_with_verified_identity)}
  let(:mail) {Verifier.verify(user.password_identity)}
   
  it 'should have the correct subject' do
    mail.subject.should == 'Lovebnb - Verify your email address now'
  end

  it 'should send an email to the user.password_identitys password identity' do
    mail.to.should == [user.password_identity.email]
  end

  it 'should have a link to the registration_controller#verify action' do
    mail.body.should have_content(verify_registration_path(user.password_identity.validate_email_token.guid))
  end

  it 'should generate an identity token for email verification' do
    user.password_identity.validate_email_token.destroy
    Verifier.verify(user.password_identity)
    user.password_identity.validate_email_token.should be_a_kind_of Tokens::ValidateEmail
  end

end
