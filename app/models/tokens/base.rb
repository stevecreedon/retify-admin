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
  class Base < ActiveRecord::Base
    
    self.table_name = :identity_tokens

    before_create :set_guid

    def to_param
      guid
    end

    private

    def set_guid
      self.guid = SecureRandom.urlsafe_base64;
    end

  end
end
