FactoryBot.define do
  # patterns
  # - order_price 0(normal)
  # - order_price 10000(normal)
  # - order_price 10001(bronze)
  # - order_price 30000(bronze)
  # - order_price 30001(silver)
  # - order_price 70000(silver)
  # - order_price 70001(gold)
  # - order_price 100000(gold)
  # - order_price 100001(pratinum)
  factory :user do
    name "user"
    rank "normal"

    factory :user_0 do
    end

    factory :user_10000 do
      after(:create) do |user, _|
        create(:order_10000, user_id: user.id)
      end
    end

    factory :user_10001 do
      after(:create) do |user, _|
        create(:order_10001, user_id: user.id)
      end
    end

    factory :user_30001 do
      after(:create) do |user, _|
        create(:order_30001, user_id: user.id)
      end
    end
  end
end
