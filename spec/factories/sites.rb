# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :subdomain do |n|
   "subdomain#{n}"
  end

  sequence :domain do |n|
   "www.domain#{n}.com"
  end

  factory :site do
    title     "Site title"
    subdomain { generate(:subdomain) }
    domain    { generate(:domain) }
    phone     '0987654321'
    email     { user.password_identity.email }
    style     "style_01"
    user      { FactoryGirl.create(:user_with_verified_identity) }
    address
  end
end
