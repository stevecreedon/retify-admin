# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name     "User name"
    phone    "0987654321"
    address

    factory :user_with_identity do
      ignore do
        identity_count 1
      end

      before(:create) do | user, evaluator |
        evaluator.identity_count.times do | index |
          user.identities << FactoryGirl.create(:identity, {
            name: user.name, provider: 'password', password: 'pass', user: nil
          })
        end
      end
    end
  end
end
