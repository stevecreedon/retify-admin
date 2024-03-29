# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name     "User name"
    phone    "0987654321"

    factory :user_with_verified_identity do
      ignore do
        identity_count 1
      end

      before(:create) do | user, evaluator |
        evaluator.identity_count.times do | index |
          user.password_identity = FactoryGirl.build(:password_identity)
        end
      end
      after(:create) do | user, evaluator |
        user.password_identity.verify!
      end
    end

    factory :user_with_identity do
      ignore do
        identity_count 1
      end

      before(:create) do | user, evaluator |
        evaluator.identity_count.times do | index |
          user.password_identity = FactoryGirl.build(:password_identity)
        end
      end
    end
  end
end
