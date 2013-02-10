class User < ActiveRecord::Base
  has_many :properties
  has_many :sites
  has_many :identities

  validates :identities, :presence => true

  before_create {|model| model.guid = SecureRandom.urlsafe_base64}

  def self.from_omniauth(auth)
    #note we don't use name in this lookup. Suspect uid is a combination of oauth[name] and password 
    identity = Identity.where(provider: auth["provider"], password_digest: auth["uid"]).first
    if identity
      return identity.user
    else
      return create_with_omniauth(auth)
    end
  end

  def self.create_with_omniauth(auth)
    identity = Identity.create!({
      provider:        auth["provider"],
      password_digest: auth["uid"],
      name:            auth["info"]["name"], #this can be email for some providers like omniauth-password
      email:           auth["info"]["email"] #email not required in oauth spec. Twitter, for example, doesn't provide email
    })
    User.create! do | user |
      user.identities << identity
    end
  end

  def verified? 
    identities.rentified.unverified.count == 0 
  end

  def email
    identities.rentified.first.try(:email)
  end

end
