# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  
  factory :identity do
    info    { { email: generate(:email)} }
    password 'passwd'
    provider 'password'
  end
end
