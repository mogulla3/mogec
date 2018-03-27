FactoryBot.define do
  factory :order do
    ordered_at Time.zone.now - 1.month
  end
end
