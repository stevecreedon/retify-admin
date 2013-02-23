class UserDecorator < ApplicationDecorator
  delegate_all

  def nag?
    rentified? && identities.rentified.first.verifying?
  end
end
