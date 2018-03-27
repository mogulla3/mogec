FactoryBot.define do
  factory :item do
    name "item"
    price 1
    association :store, factory: :store
  end
end
