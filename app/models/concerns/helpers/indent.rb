# frozen_string_literal: true

module Helpers
  module Indent
    extend ActiveSupport::Concern

    def total_product
      line_items&.size
    end

    def total_quantity
      line_items&.sum(&:quantity)
    end
  end
end
