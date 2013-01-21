class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :name, :provider

  has_many :properties
  has_many :sites

  def self.from_omniauth(auth)
    where(provider: auth["provider"], password_digest: auth["uid"]).first || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.password_digest = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end
end
