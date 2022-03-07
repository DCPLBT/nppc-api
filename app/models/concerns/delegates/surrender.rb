# frozen_string_literal: true

module Delegates
  module Surrender
    extend ActiveSupport::Concern

    included do
      delegate(
        :id, :name, :region_name, :district_name, :extension_name,
        to: :surrenderer, prefix: true, allow_nil: true
      )
      delegate(
        :id, :name, :region_name, :district_name, :extension_name,
        to: :surrendered_to, prefix: true, allow_nil: true
      )
      delegate(:name, to: :region, prefix: true, allow_nil: true)
      delegate(:name, to: :district, prefix: true, allow_nil: true)
      delegate(:name, to: :extension, prefix: true, allow_nil: true)
      delegate(:name, to: :user, prefix: true, allow_nil: true)
      delegate(:name, to: :received_by, prefix: true, allow_nil: true)
    end
  end
end
