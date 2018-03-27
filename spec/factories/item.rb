FactoryBot.define do
  factory :item do
    name "item"
    association :store, factory: :store

    factory :item_10000 do
      price 10000
    end

    factory :item_10001 do
      price 10001
    end

    factory :item_30001 do
      price 30001
    end
  end
end
