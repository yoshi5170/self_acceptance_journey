FactoryBot.define do
  factory :diary do
    date { Date.current.prev_day(3) }
    association :user
  end
end
