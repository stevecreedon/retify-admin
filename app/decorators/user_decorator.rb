class UserDecorator < ApplicationDecorator
  delegate_all

  def nag?
    identity = password_identity.try(:verifying?)
  end
end
