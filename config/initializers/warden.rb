# frozen_string_literal: true

Rails.application.middleware.use Warden::Manager do |config|
  config.default_strategies :session
  config.failure_app = -> (_) { [401, { 'Content-Type' => 'text/plain' }, ['Not authorized']] }
end

Warden::Manager.serialize_into_session(&:id)
Warden::Manager.serialize_from_session { |id| User.find(id) }

Warden::Strategies.add(:session) do
  def valid?
    email && password
  end

  def authenticate!
    user = User.find_by!(email: email)

    user.authenticate(password) ? success!(user) : fail!
  rescue ActiveRecord::RecordNotFound
    fail!
  end

  def email
    params.dig('auth', 'email')
  end

  def password
    params.dig('auth', 'password')
  end
end
