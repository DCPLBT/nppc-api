# frozen_string_literal: true

module Helpers
  module LineItem
    extend ActiveSupport::Concern

    def total_price
      quantity * (unit_price || 0)
    end
  end
end
