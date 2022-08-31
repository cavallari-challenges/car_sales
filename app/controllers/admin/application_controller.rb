# frozen_string_literal: true

module Admin
  class ApplicationController < ::ApplicationController

    protected

    def authenticate!
      super and return if current_user.blank?

      head :unauthorized unless current_user.admin?
    end
  end
end
