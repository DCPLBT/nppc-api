# frozen_string_literal: true

class AgencyPopulator < BasePopulator
  def run
    agencies
      .public_send(:search, q)
  end

  private

  def agencies
    @agencies ||= (parent ? parent.agencies : Agency).includes(:user)
  end
end
