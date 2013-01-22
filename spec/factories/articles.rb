# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    source_id   1
    source_type "property"
    title       "Article title"
    description "Article description"
    group       "terms"
  end
end
