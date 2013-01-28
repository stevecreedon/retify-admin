# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :property do
    title       "Property title"
    description "Property description"
    user        { FactoryGirl.create(:user_with_identity) }
    address
  end
end
