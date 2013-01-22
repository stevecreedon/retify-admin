# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calendar do
    google_calendar_path "MyString"
    enabled false
    property_id 1
  end
end
