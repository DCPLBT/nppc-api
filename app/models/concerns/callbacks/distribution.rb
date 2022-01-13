# frozen_string_literal: true

module Callbacks
  module Distribution
    extend ActiveSupport::Concern

    included do
      before_create :assign_defaults
      after_create :update_stock
    end

    private

    def assign_defaults
      assign_attributes(
        reference_no: CodeGenerator.new.generate,
        state: :distributed
      )
    end

    def update_stock
      line_items.each do |li|
        li.stock&.update(quantity: (li.stock&.quantity || 0) - li.quantity)
      end
    end
  end
end
