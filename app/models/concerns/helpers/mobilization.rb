# frozen_string_literal: true

module Helpers
  module Mobilization
    extend ActiveSupport::Concern

    def mobilizer
      @mobilizer ||= mobilizers.last
    end

    def mobilized_to
      @mobilized_to ||= mobilized_tos.last
    end

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
