FactoryBot.define do
  factory :planted_flower do
    association :user
    association :flower
    added_at { Date.current.prev_day(3) }
  end
end
