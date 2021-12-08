# frozen_string_literal: true

module Delegates
  module User
    extend ActiveSupport::Concern

    included do
      delegate(
        :region_name, :district_name, :extension_name, :name, :employee_type, :employee_id, :designation, :agency,
        to: :profile,
        allow_nil: true
      )
    end
  end
end
