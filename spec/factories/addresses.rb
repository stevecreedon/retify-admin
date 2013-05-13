# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address      "55 Oxford street"
    country      "United Kingdom"
    city         "London"
    post_code    "W1D 2EQ"
    lat          1
    lng          1
  end
end
