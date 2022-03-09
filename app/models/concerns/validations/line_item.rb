# frozen_string_literal: true

module Validations
  module LineItem
    extend ActiveSupport::Concern

    included do
      validates_presence_of :quantity
      validates_numericality_of :quantity, greater_than: 0

      validate :validate_stock, unless: :skip_stock_validation?, on: %i[create update]
    end

    def validate_stock
      return if (stock&.quantity || 0) >= (quantity || 0)

      errors.add(:base, :insufficient_stock, product: stock&.product_name, stock: stock&.quantity)
    end
  end
end
