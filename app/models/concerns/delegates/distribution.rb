# frozen_string_literal: true

module Delegates
  module Distribution
    extend ActiveSupport::Concern

    included do
      delegate(
        :id, :name, :region_name, :district_name, :extension_name,
        to: :distributor, prefix: true, allow_nil: true
      )
      delegate(
        :id, :name, :region_name, :district_name, :extension_name,
        to: :distributed_to, prefix: true, allow_nil: true
      )
      delegate(:name, to: :region, prefix: true, allow_nil: true)
      delegate(:name, to: :district, prefix: true, allow_nil: true)
      delegate(:name, to: :extension, prefix: true, allow_nil: true)
    end
  end
end
