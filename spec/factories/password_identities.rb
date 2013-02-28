# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
   "person#{n}@domain.com"
  end

  factory :password_identity do
    email    { generate(:email) }
    password 'passwd'
    confirm 'passwd'
  end 
end
