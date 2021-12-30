# frozen_string_literal: true

class EmployeeTypePopulator < BasePopulator
  def run
    employee_types
      .public_send(:search, q)
  end

  private

  def employee_types
    @employee_types ||= (parent ? parent.employee_types : EmployeeType).includes(:user)
  end
end
