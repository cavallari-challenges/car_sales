# frozen_string_literal: true

CAR_YEARS_RANGE = (1980..Date.current.next_year.year).to_a

FactoryBot.define do
  factory :car do
    dealership

    name { Faker::Name.first_name }
    price { 10_000.00 }
    year { CAR_YEARS_RANGE.sample }
  end
end
