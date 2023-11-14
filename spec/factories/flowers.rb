FactoryBot.define do
  factory :flower do
    sequence(:name) { |n| "flower_#{n}" }

    trait :threshold_five do
      threshold { 5 }
    end

    trait :threshold_ten do
      threshold { 10 }
    end

    after(:build) do |flower|
      filename = flower.threshold == 5 ? 'flower01.png' : 'flower02.png'
      flower.flower_image.attach(
        io: File.open("#{Rails.root}/spec/fixtures/image/#{filename}"),
        filename:,
        content_type: 'image/png'
      )
    end
  end
end
