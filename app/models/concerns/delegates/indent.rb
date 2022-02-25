# frozen_string_literal: true

module Delegates
  module Indent
    extend ActiveSupport::Concern

    included do
      delegate(
        :id, :name, :region_name, :district_name, :extension_name, :company_name, :village_name,
        to: :requester, prefix: true, allow_nil: true
      )
      delegate(
        :id, :name, :region_name, :district_name, :extension_name, :company_name, :village_name,
        to: :forwarded_to, prefix: true, allow_nil: true
      )
      delegate(:name, to: :region, prefix: true, allow_nil: true)
      delegate(:name, to: :district, prefix: true, allow_nil: true)
      delegate(:name, to: :extension, prefix: true, allow_nil: true)
      delegate(:name, to: :company, prefix: true, allow_nil: true)
    end
  end
end
