# frozen_string_literal: true

FactoryBot.define do
  factory :bookmark do
    tweet
    folder
  end
end
