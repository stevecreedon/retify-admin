# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :email do |n|
   "person#{n}@domain.com"
  end

  factory :identity do
    name     { user.name }
    email    { generate(:email) }
    password 'pass'
    provider 'password'
    user
  end
end
