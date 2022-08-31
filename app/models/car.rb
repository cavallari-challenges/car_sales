# frozen_string_literal: true

class Car < ApplicationRecord
  MONTHLY_DEPRECATION_VALUE = 0.02

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :year, presence: true, numericality: { less_than_or_equal_to: Date.current.next_year.year }

  belongs_to :dealership

  enum condition: { brand_new: 0, used: 1 }

  def deprecated_price
    @depecated_price ||= price - (price * (months_in_dealership * MONTHLY_DEPRECATION_VALUE))
  end

  def months_in_dealership
    @months_in_dealership ||= begin
      current_date = Date.current
      created_date = created_at.to_date

      (current_date.month + current_date.year * 12) - (created_date.month + created_date.year * 12).abs
    end
  end
end
