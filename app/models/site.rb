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
                        uniqueness: true,
                        length:     { minimum: 3 },
                        exclusion:  { in: %w(admin info doc wiki staging mail pop smtp pop3 landing news blog forum storage finance analytics stats) },
                        format:     { with: /^[a-z0-9_-]+$/ }
  validates :domain,    uniqueness:  true,
                        allow_blank: true

  validate :domain_cannot_contain_our_domain

private

  def domain_cannot_contain_our_domain
    if domain.match('kuztus.com')
      errors.add(:domain, "can't contain our domain name")
    end
  end
end
