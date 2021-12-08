# frozen_string_literal: true

module Callbacks
  module Stock
    extend ActiveSupport::Concern

    included do
      before_save :assign_defaults
    end

    def assign_defaults
      assign_attributes(
        unit: product.unit,
        obsolete_date: expiry_date + 1 # TODO: replace 1 with the value from settings
      )
    end
  end
end
