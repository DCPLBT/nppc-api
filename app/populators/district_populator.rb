# frozen_string_literal: true

class DistrictPopulator < BasePopulator
  def run
    districts
      .public_send(:search, q)
  end

  private

  def districts
    @districts ||= parent ? parent.districts : District
  end
end
