# frozen_string_literal: true

class DistrictPopulator < BasePopulator
  def run
    districts
      .public_send(:search, q)
      .yield_self { |districts| filter_by_disabled(districts) }
  end

  private

  def districts
    @districts ||= parent ? parent.districts : District
  end
end
