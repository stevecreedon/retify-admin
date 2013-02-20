class UserDecorator < ApplicationDecorator

  def nag?
    !verified?
  end

  def send_verification_email!
    
  end

end
