# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :property do
    title       "Property title"
    description "Property description"
    site
  end
end
