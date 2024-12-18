FactoryBot.define do
  factory :list do
    association :board

    title { Faker::Lorem.word }

    sequence :position do |n|
      n
    end
  end
end
