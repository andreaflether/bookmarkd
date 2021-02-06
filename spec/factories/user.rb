FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    username { Faker::Internet.username(specifier: 4..15, separators: %w[_]) }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
