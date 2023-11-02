FactoryBot.define do
  factory :result do
    score_range_start { 1 }
    score_range_end { 1 }
    description { "MyText" }
    title { "MyString" }
  end
end
