class Identity < ActiveRecord::Base
  has_secure_password

  attr_accessible :password, :provider, :name, :email

  validates :provider, :presence => true
  validates :name, :presence => true

  belongs_to :user
end