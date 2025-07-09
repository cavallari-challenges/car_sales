# frozen_string_literal: true

FactoryBot.define do
  factory :dealership do
    name { Faker::Name.first_name }
  end
end
