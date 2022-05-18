# frozen_string_literal: true

module Callbacks
  module Stock
    extend ActiveSupport::Concern

    included do
      before_validation :assign_defaults, on: :create
      after_create :create_obsolete_notification
      after_create :update_total_quantity_procured
    end

    private

    def assign_defaults
      assign_attributes(
        unit_id: product&.unit_id,
        obsolete_date: (expiry_date || Date.current) + (Setting.obsolete.first&.meta&.dig('period')&.to_i || 0).months
      )
    end

    def create_obsolete_notification
      ::ObsoleteWorker.perform_in(obsolete_date.to_time, id)
    end

    def update_total_quantity_procured
      update_columns(update_total_quantity_procured: quantity)
    end
  end
end
