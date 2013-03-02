module Tokens
class Base < ActiveRecord::Base
  belongs_to :user

  set_table_name :identity_tokens

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
