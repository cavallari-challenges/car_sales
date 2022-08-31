# frozen_string_literal: true

module Layout
  class NavbarComponent < ViewComponent::Base
    attr_reader :current_user

    def initialize(current_user:)
      @current_user = current_user
    end

    def can?(...)
      @can ||= Ability.new(current_user).can?(...)
    end
  end
end
