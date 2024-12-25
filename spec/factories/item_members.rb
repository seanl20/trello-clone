FactoryBot.define do
  factory :item_member do
    association :item
    association :user
  end
end
