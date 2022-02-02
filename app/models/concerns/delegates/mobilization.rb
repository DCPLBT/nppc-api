# frozen_string_literal: true

module Delegates
  module Mobilization
    extend ActiveSupport::Concern

    included do
      delegate(
        :id, :name, :region_name, :district_name, :extension_name, :company_name,
        to: :mobilizer, prefix: true, allow_nil: true
      )
      delegate(
        :id, :name, :region_name, :district_name, :extension_name, :company_name,
        to: :mobilized_to, prefix: true, allow_nil: true
      )
      delegate(:name, to: :approved_by, prefix: true, allow_nil: true)
      delegate(:name, to: :region, prefix: true, allow_nil: true)
      delegate(:name, to: :district, prefix: true, allow_nil: true)
      delegate(:name, to: :extension, prefix: true, allow_nil: true)
      delegate(:name, to: :company, prefix: true, allow_nil: true)
    end
  end
end
