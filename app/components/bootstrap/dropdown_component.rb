# frozen_string_literal: true

module Bootstrap
  class DropdownComponent < ViewComponent::Base
    renders_many :buttons, -> (title, url) do
      link_to title, url, class: 'dropdown-item'
    end

    def initialize(title:)
      @title = title
    end
  end
end
