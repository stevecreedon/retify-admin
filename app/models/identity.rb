# == Schema Information
#
# Table name: identities
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  provider        :string(255)
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  state           :string(255)
#  type            :string(255)
#

class Identity < ActiveRecord::Base

  serialize :info, Hash
  serialize :extra, Hash
  serialize :credentials, Hash

  belongs_to :user
  
  scope :find_from_auth, lambda{|auth| where(provider: auth[:provider], password_digest: auth[:uid]) }

  before_validation Proc.new{|model| model.provider = self.class::PROVIDER}

  def self.create_from_auth(auth)
    
    case auth[:provider]
    when 'password'
      klazz = PasswordIdentity
    when 'google_auth2'
      klazz = GoogleIdentity
    else
      raise "unkown auth provider #{auth["provider"]}"
    end

    klazz.create_from_auth(auth)

  end
end
