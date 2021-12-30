# frozen_string_literal: true

class EmployeeTypeForm < BaseForm
  def show
    employee_type
  end

  def create
    employee_type.save
  end

  def update
    employee_type.update(params)
  end

  def destroy
    employee_type.destroy
  end

  private

  def employee_type
    @employee_type ||= id ? EmployeeType.find(id) : EmployeeType.new(params.merge(user_id: current_user.id))
  end
end
