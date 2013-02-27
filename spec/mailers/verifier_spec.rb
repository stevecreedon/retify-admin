require 'spec_helper'

describe Verifier do

  let(:user){FactoryGirl.create(:user_with_identity)}
  let(:mail) {Verifier.verify(user)}
   
  it 'should have the correct subject' do
    mail.subject.should == 'Lovebnb - Verify your email address now'
  end

  it 'should send an email to the users password identity' do
    mail.to.should == [user.email]
  end

  it 'should have a link to the registration_controller#verify action' do
    mail.body.should have_content(verify_registration_path(user.identity_tokens.validate_email.first.guid))
  end

  it 'should generate an identity token for email verification' do
    user.identity_tokens.delete_all
    Verifier.verify(user)
    user.identity_tokens.first.purpose.should == 'validate_email'
  end

end
