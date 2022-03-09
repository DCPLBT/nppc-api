# frozen_string_literal: true

module Helpers
  module Surrender
    extend ActiveSupport::Concern

    def total_price
      @total_price ||= line_items.sum(&:total_price)
    end

    def total_quantity
      @total_quantity ||= line_items.sum(&:quantity)
    end

    def total_product
      @total_product ||= line_items.size
    end
  end
end
