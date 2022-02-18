# frozen_string_literal: true

module Delegates
  module User
    extend ActiveSupport::Concern

    included do
      delegate(
        :region_id, :region_name, :district_id, :district_name, :extension_id, :extension_name, :village_name, :name,
        :employee_type, :employee_id, :designation, :agency, :region, :district, :extension, :company, :company_id,
        :company_name,
        to: :profile,
        allow_nil: true
      )
    end
  end
end
