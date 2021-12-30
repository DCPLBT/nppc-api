# frozen_string_literal: true

module Callbacks
  module LineItem
    extend ActiveSupport::Concern

    included do
      before_save :assign_defaults
    end

    private

    def assign_defaults
      assign_attributes(
        unit_price: stock&.unit_price || 0
      )
    end
  end
end
