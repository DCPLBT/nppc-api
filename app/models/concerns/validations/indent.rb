# frozen_string_literal: true

module Validations
  module Indent
    extend ActiveSupport::Concern

    included do
      validates_inclusion_of :draft, in: [true, false]
      with_options unless: :draft? do
        validates_presence_of :region_id, :district_id, if: ->(x) { x.dao? }
        validates_presence_of :region_id, :district_id, :extension_id, if: ->(x) { x.ea? }

        validate :indent_dates
      end
    end

    def indent_dates
      date = ::Setting.indent.first&.meta&.dig('requisition_date')
      return unless date.present? && Time.current.after?(date.to_time)

      errors.add(:base, :cannot_make_indent, date: date)
    end
  end
end
