# frozen_string_literal: true

module Validations
  module EmployeeType
    extend ActiveSupport::Concern

    included do
      validates_presence_of :name
      validates_uniqueness_of :name, scope: :role, case_sensitive: false
    end
  end
end
