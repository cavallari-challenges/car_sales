# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:year).is_less_than_or_equal_to(Date.current.next_year.year) }
  end

  describe 'enums' do
    it { should define_enum_for(:condition).with_values(%i[brand_new used]) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:dealership) }
  end

  describe '#months_in_dealership' do
    subject { car.months_in_dealership }

    let(:car) { travel_to(10.months.ago) { create(:car) } }

    it { is_expected.to eq(10) }
  end

  describe '#deprecated_price' do
    subject { car.deprecated_price }

    let(:car_price) { 10_000.00 }
    let(:car) { travel_to(10.months.ago) { create(:car, price: car_price) } }
    let(:expected) { car_price - (car_price * (10 * 0.02)) }

    it { is_expected.to eq(expected) }
  end
end
