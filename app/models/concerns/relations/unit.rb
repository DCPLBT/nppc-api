# frozen_string_literal: true

module Relations
  module Unit
    extend ActiveSupport::Concern

    included do
      belongs_to :user
    end
  end
end
