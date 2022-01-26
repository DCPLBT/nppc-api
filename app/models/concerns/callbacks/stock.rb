# frozen_string_literal: true

module Callbacks
  module Stock
    extend ActiveSupport::Concern

    included do
      before_validation :assign_defaults, on: :create
    end

    def assign_defaults
      assign_attributes(
        unit_id: product&.unit_id,
        obsolete_date: (expiry_date || Date.current) + (Setting.obsolete.first&.meta&.dig('period') || 0).months
      )
    end
  end
end
