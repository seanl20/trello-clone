FactoryBot.define do
  factory :item do
    association :list

    title { "MyString" }
  end
end
