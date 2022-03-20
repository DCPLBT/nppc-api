# frozen_string_literal: true

module Callbacks
  module Stock
    extend ActiveSupport::Concern

    included do
      before_validation :assign_defaults, on: :create
      after_create :create_obsolete_notification
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
  end
end
