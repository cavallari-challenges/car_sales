# frozen_string_literal: true

module Layout
  class FlashComponent < ViewComponent::Base
    attr_reader :message

    ALERT_MAPPING = {
      notice: :info,
      error: :danger,
      success: :success
    }.with_indifferent_access.freeze

    def initialize(flash)
      @type, @message = flash[:flash]
    end

    def type
      ALERT_MAPPING[@type] || 'primary'
    end
  end
end
