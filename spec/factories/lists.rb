FactoryBot.define do
  factory :list do
    association :board

    title { Faker::Lorem.word }
  end
end
