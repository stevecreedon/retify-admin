class Identity < ActiveRecord::Base
  has_secure_password

  attr_accessible :password, :provider, :name, :email

  validates :provider, :presence => true
  validates :email, :presence => true

  belongs_to :user

  scope :rentified, lambda{where(:provider => "password")}
  scope :unverified, lambda{rentified.where(:email_verified => nil)}
 
end
