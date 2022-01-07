# frozen_string_literal: true

module Delegates
  module User
    extend ActiveSupport::Concern

    included do
      delegate(
        :region_id, :region_name, :district_id, :district_name, :extension_id, :extension_name, :name, :employee_type,
        :employee_id, :designation, :agency, :region, :district, :extension,
        to: :profile,
        allow_nil: true
      )
    end
  end
end
