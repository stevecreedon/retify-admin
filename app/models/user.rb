# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state      :string(255)
#  address_id :integer
#  phone      :string(255)
#

class User < ActiveRecord::Base
  has_many :properties
  has_many :sites
  has_one :password_identity, :dependent => :destroy, :validate => true
  has_one :google_identity, :dependent => :destroy, :validate => true 

  has_one :forgot_password_token, :class_name => Tokens::ForgotPassword, :dependent => :destroy


  belongs_to :address

  accepts_nested_attributes_for :address

  attr_accessible :name, :phone

  #validates :identities, :presence => true
  validates :name,  :presence => true, unless: 'new_record?'
  validates :phone, :presence => true, unless: 'new_record?'

  def self.from_omniauth(auth)
    #note we don't use name in this lookup. Suspect uid is a combination of oauth[name] and password 
    identity = Identity.find_from_auth(auth)
    if identity
      return identity.user
    else
      return create_with_omniauth(auth)
    end
  end

  def self.create_with_omniauth(auth)
    User.create! do | user |
      user.add_identity_from_auth(auth)
    end
  end

  def add_identity_from_auth(auth)
    identity = Identity.create_from_auth(auth)
    self.password_identity = identity if identity.is_a?(PasswordIdentity)
    self.google_identity = identity if identity.is_a?(GoogleIdentity)
    identity
  end

  def email
    password_identity.try(:email)
  end
 
end
