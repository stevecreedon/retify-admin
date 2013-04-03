# == Schema Information
#
# Table name: identity_tokens
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  guid        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  valid_until :datetime
#  type        :string(255)
#

module Tokens
  class ForgotPassword < Tokens::Base

    before_create :set_valid_until

    scope :valid, lambda{|guid| Tokens::ForgotPassword.where("guid = ? AND valid_until > ?", guid, Time.now)} 

    private

    def set_valid_until
      self.valid_until = Time.gm(*Time.now) + 24.hours
    end

  end
end
