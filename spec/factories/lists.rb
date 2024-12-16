FactoryBot.define do
  factory :list do
    association :board

    title { Faker::Lorem.word }
    position { 0 }
  end
end
