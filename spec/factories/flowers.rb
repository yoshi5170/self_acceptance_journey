FactoryBot.define do
  factory :flower do
    sequence(:name) { |n| "flower_#{n}" }
    threshold { 10 }
  end
end
