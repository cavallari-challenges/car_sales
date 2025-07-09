# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password :password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  enum role: { general: 0, admin: 1 }
end
