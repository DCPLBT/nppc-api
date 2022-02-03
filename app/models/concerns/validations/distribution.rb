# frozen_string_literal: true

module Validations
  module Distribution
    extend ActiveSupport::Concern

    included do
      validates_presence_of :distributed_type
      validates_presence_of :line_items, message: :line_item_required

      validate :validate_stock, if: :distributed?
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
