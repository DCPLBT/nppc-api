# frozen_string_literal: true

class UnitPopulator < BasePopulator
  def run
    units
      .public_send(:search, q)
  end

  private

  def units
    @units ||= (parent ? parent.units : Unit).includes(:user)
  end
end
