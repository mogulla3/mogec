FactoryBot.define do
  factory :item do
    factory :item_10001 do
      name "item"
      association :store, factory: :store
      price 10_001
    end
  end
end
