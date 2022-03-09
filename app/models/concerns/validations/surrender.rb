# frozen_string_literal: true

module Validations
  module Surrender
    extend ActiveSupport::Concern

    included do
      validates_presence_of :surrender_type
      validates_presence_of :line_items, message: :line_item_required
      validates_presence_of :region_id, if: ->(x) { x.adrc? }

      validate :validate_stock, if: :surrendered?
    end

    private

    def validate_stock
      line_items.each do |li|
        next if (li.stock&.quantity || 0) >= li.quantity

        errors.add(:base, :insufficient_stock, product: li.stock&.product_name, stock: li.stock&.quantity)
      end
    end
  end
end
