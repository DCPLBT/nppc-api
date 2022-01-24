# frozen_string_literal: true

module Helpers
  module Surrender
    extend ActiveSupport::Concern

    def surrenderer
      @surrenderer ||= surrenderers.includes(:profile).last
    end

    def surrendered_to
      @surrendered_to ||= surrendered_tos.includes(:profile).last
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
