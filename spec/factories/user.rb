FactoryBot.define do
  factory :user do
    name "user"
    rank "normal"

    trait :purchased do
      transient do
        price 1
      end

      after(:create) do |user, evaluator|
        item = create(:item, price: evaluator.price)
        create(:order, user_id: user.id, item_id: item.id)
      end
    end
  end
end