# frozen_string_literal: true

class UnitForm < BaseForm
  def show
    unit
  end

  def create
    unit.save
  end

  def update
    unit.update(params)
  end

  def destroy
    unit.destroy
  end

  private

  def unit
    @unit ||= id ? Unit.find(id) : Unit.new(params.merge(user_id: current_user.id))
  end
end
