# frozen_string_literal: true

class EmployeeTypePopulator < BasePopulator
  def run
    employee_types
      .public_send(:search, q)
      .yield_self { |employee_types| filter_by_disabled(employee_types) }
  end

  private

  def employee_types
    @employee_types ||= (parent ? parent.employee_types : EmployeeType).includes(:user)
  end
end
