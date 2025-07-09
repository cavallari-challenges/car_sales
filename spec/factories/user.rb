# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    role { :general }
    password { Faker::Internet.password }
    email { Faker::Internet.email }

    trait :admin do
      role { :admin }
    end
  end
end
