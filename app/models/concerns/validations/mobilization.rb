# frozen_string_literal: true

module Validations
  module Mobilization
    extend ActiveSupport::Concern

    included do
      validates_presence_of :category
      validates_presence_of :line_items, message: :line_item_required
      validates_presence_of :approved_by, if: :approved?
      validates_presence_of :region_id, if: ->(x) { x.adrc? }
      validates_presence_of :region_id, :district_id, :extension_id, if: ->(x) { x.ea? }
      validates_presence_of :company_id, if: ->(x) { x.mhv? }

      validate :validate_stock, if: :valid_state?
      validate :validate_approved_by, if: :approved?
    end

    private

    def validate_stock
      line_items.each do |li|
        next if (li.stock&.quantity || 0) >= li.quantity

        errors.add(:base, :insufficient_stock, product: li.stock&.product_name, stock: li.stock&.quantity)
      end
    end

    def validate_approved_by
      return if approved_by.nppc?

      errors.add(:base, :only_nppc_can_approve)
    end
  end
end
