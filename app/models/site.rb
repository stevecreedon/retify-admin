# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  subdomain  :string(255)
#  domain     :string(255)
#  style      :string(255)
#  email      :string(255)
#  phone      :string(255)
#  address_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Site < ActiveRecord::Base
  attr_accessible :domain, :subdomain, :style, :title, :address, :user, :email, :phone

  belongs_to  :address, dependent: :destroy
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

  accepts_nested_attributes_for :address

private

  def domain_cannot_contain_our_domain
    if domain && domain.match('kuztus.com')
      errors.add(:domain, "can't contain our domain name")
    end
  end
end
