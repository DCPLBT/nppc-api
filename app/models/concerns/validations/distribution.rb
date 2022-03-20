# frozen_string_literal: true

module Validations
  module Distribution
    extend ActiveSupport::Concern

    included do
      validates_presence_of :distributed_type
      validates_presence_of :line_items, message: :line_item_required
      validates_presence_of :region_id, if: ->(x) { x.adrc? }
      validates_presence_of :region_id, :district_id, :extension_id, if: ->(x) { x.ea? }
      validates_presence_of :company_id, if: ->(x) { x.mhv? }
      validates_presence_of :consumer_cid, :village, if: :individual?

      # validate :validate_stock, if: :distributed?
    end

    # def validate_stock
    #   line_items.each do |li|
    #     next if (li.stock&.quantity || 0) >= li.quantity
    #
    #     errors.add(:base, :insufficient_stock, product: li.stock&.product_name, stock: li.stock&.quantity)
    #   end
    # end
  end
end
