# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site, :class => 'Sites' do
    title     "Site title"
    subdomain "example"
    domain    "www.example.com"
    style     "style_01"
  end
end
