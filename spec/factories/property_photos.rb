# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :property_photo do
    image     { File.open("#{Rails.root}/spec/static/property_photo.jpg") }
    property
  end
end
