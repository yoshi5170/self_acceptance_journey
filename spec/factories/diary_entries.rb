FactoryBot.define do
  factory :diary_entry do
    content { "MyString" }
    diary { nil }
  end
end
