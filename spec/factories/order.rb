FactoryBot.define do
  factory :order do
    factory :order_10001 do
      association :item, factory: :item_10001
      ordered_at Time.zone.now - 1.month
    end
  end
end
