# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
   "person#{n}@domain.com"
  end

  factory :user do
    email     { generate(:email) }
    name     "User name"
    password "pass"
    provider "password"
  end
end
