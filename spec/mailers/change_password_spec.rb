require "spec_helper"

describe ChangePassword do

  let(:user){FactoryGirl.create(:user_with_identity)}
  let(:mail) {
    Timecop.travel(Time.new(2013,10,11,20,30)) do
      ChangePassword.request_new(user)
    end
  }

  it 'should have the correct subject' do
    mail.subject.should == "LoveBnB - change your password"
  end

  it 'should send an email to the users password identity' do
    mail.to.should == [user.email]
  end

  it 'should include a valid until time' do
    mail.body.should have_content('valid until Sat Oct 12 20:30:00 2013')
  end

  it 'should have a link to the registration_controller#verify action' do
    mail.body.should have_content(edit_password_path(tid: user.forgot_password_token.guid))
  end

  it 'should generate an identity token for email verification' do
    user.forgot_password_token.should be_nil
    ChangePassword.request_new(user)
    user.forgot_password_token.should_not be_nil
  end

end
