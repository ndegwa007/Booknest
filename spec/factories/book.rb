FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    isbn { Faker::Number.number(digits: 13) }
    status { 'available' }

    trait :borrowed do
      status { 'borrowed' }
    end
  end
end
