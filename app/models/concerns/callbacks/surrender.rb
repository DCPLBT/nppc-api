# frozen_string_literal: true

module Callbacks
  module Surrender
    extend ActiveSupport::Concern

    included do
      before_create :assign_defaults
      after_create :update_stock
    end

    private

    def assign_defaults
      assign_attributes(
        reference_no: CodeGenerator.new.generate,
        state: :surrendered
      )
    end

    def update_stock # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/AbcSize
      transaction do
        line_items.each do |li|
          if (li.stock&.quantity || 0) < li.quantity
            errors.add(:base, :insufficient_stock, product: li.stock&.product_name, stock: li.stock&.quantity)
            return false
          end

          li.stock&.update(quantity: (li.stock&.quantity || 0) - li.quantity)
        end
      end
    end
  end
end
