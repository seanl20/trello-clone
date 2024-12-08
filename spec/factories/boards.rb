FactoryBot.define do
  factory :board do
    association :user

    name { "MyString" }
  end
end
