# frozen_string_literal: true

class RegionPopulator < BasePopulator
  def run
    regions
      .public_send(:search, q)
      .yield_self { |regions| filter_by_disabled(regions) }
  end

  private

  def regions
    @regions ||= Region
  end
end
