# frozen_string_literal: true

class AgencyPopulator < BasePopulator
  def run
    agencies
      .public_send(:search, q)
      .yield_self { |agencies| filter_by_disabled(agencies) }
  end

  private

  def agencies
    @agencies ||= (parent ? parent.agencies : Agency).includes(:user)
  end
end
