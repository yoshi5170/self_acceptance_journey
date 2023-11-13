FactoryBot.define do
  factory :diary_entry do
    sequence(:content) { |n| "diary_#{n}" }
    association :diary
  end
end
