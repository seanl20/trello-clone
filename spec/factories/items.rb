FactoryBot.define do
  factory :item do
    association :list

    title { Faker::Lorem.word }
  end
end
