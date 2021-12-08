# frozen_string_literal: true

module Helpers
  module Stock
    extend ActiveSupport::Concern

    def total_price
      @total_price ||= unit_price * quantity
    end
  end
end
