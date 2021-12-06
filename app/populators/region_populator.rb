# frozen_string_literal: true

class RegionPopulator < BasePopulator
  def run
    regions
      .public_send(:search, q)
  end

  private

  def regions
    @regions ||= Region
  end
end
