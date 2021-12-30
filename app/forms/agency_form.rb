# frozen_string_literal: true

class AgencyForm < BaseForm
  def show
    agency
  end

  def create
    agency.save
  end

  def update
    agency.update(params)
  end

  def destroy
    agency.destroy
  end

  private

  def agency
    @agency ||= id ? Agency.find(id) : Agency.new(params.merge(user_id: current_user.id))
  end
end
