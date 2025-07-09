# frozen_string_literal: true

class Dealership < ApplicationRecord
  validates :name, presence: true
end
