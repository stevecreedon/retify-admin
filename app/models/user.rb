class User < ActiveRecord::Base

  validates :identities, :presence => true
  
  has_many :properties
  has_many :sites
  has_many :identities

  def self.from_omniauth(auth)
    identity = Identity.where(provider: auth["provider"], password_digest: auth["uid"]).first
    if identity
      return identity.user
    else
      return create_with_omniauth(auth)
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      identity = Identity.new
      identity.provider = auth["provider"]
      identity.password_digest = auth["uid"]
      identity.name = auth["info"]["name"]
      identity.email = auth["info"]["email"]#email not required in oauth spec
      user.identities << identity
    end
  end
end
