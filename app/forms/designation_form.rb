# frozen_string_literal: true

class DesignationForm < BaseForm
  def show
    designation
  end

  def create
    designation.save
  end

  def update
    designation.update(params)
  end

  def destroy
    designation.destroy
  end

  private

  def designation
    @designation ||= id ? Designation.find(id) : Designation.new(params.merge(user_id: current_user.id))
  end
end
