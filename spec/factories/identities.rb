# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :email do |n|
   "person#{n}@domain.com"
  end

  factory :identity do
    email    { generate(:email) }
    password 'passwd'
    provider 'password'
  end
end
