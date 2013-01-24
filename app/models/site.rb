class Site < ActiveRecord::Base
  attr_accessible :domain, :subdomain, :style, :title, :address, :user, :email, :phone

  belongs_to  :address
  belongs_to  :user

  validates :user,      presence: true
  validates :phone,     presence: true
  validates :email,     presence: true,
                        format:   { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :style,     presence: true
  validates :subdomain, presence: true,
                        uniqueness: true
  validates :domain,    uniqueness: true
end
