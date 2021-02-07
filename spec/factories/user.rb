FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    username { Faker::Internet.username(specifier: 4..15, separators: %w[_]) }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
