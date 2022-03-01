# frozen_string_literal: true

module Relations
  module EmployeeType
    extend ActiveSupport::Concern

    included do
      belongs_to :user
      belongs_to :role, inverse_of: :employee_types

      has_many :agencies, inverse_of: :employee_type, dependent: :destroy
    end
  end
end
