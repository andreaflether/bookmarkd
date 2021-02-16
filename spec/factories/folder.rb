# frozen_string_literal: true

FactoryBot.define do
  factory :folder do
    name { Faker::Lorem.unique.word }
    # name { Faker::Kpop.girl_groups }
    description { Faker::Lorem.paragraph_by_chars(number: 200) }
    user
  end
end
