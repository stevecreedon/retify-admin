class Site < ActiveRecord::Base
  attr_accessible :domain, :subdomain, :style, :title, :address_id, :email, :phone

  belongs_to  :address
  belongs_to  :user

  has_many :properties
end
