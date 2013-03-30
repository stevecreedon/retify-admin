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
  class ValidateEmail < Tokens::Base
    scope :validate_email, lambda{where(:type => "ValidateEmail")}
  end
end
