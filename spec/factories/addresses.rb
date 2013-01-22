# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address      "Address line 1"
    address2     "Address line 2"
    country      "United Kingdom"
    city         "London"
    state        "London"
    post_code    "E11EE"
    lat          1.5
    lng          1.5
    user_set_lat 1.6
    user_set_lng 1.6
  end
end
