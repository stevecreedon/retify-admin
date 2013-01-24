# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calendar do
    path     "path_to_some_google_calendar"
    provider "google"
    enabled  true
    property
  end
end
