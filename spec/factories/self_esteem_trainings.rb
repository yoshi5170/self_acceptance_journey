FactoryBot.define do
  factory :self_esteem_training do
    trained_at { Date.current.prev_day(3) }
    association :user
  end
end
