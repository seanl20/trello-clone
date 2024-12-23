FactoryBot.define do
  factory :board_user do
    association :board
    association :user
  end
end
