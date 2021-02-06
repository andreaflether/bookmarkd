FactoryBot.define do
  factory :folder do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph_by_chars(number: 200) }
    user
  end
end
