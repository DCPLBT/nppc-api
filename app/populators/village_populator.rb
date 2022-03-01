# frozen_string_literal: true

class VillagePopulator < BasePopulator
  def run
    villages
      .public_send(:search, q)
      .yield_self { |villages| filter_by_disabled(villages) }
  end

  private

  def villages
    @villages ||= parent ? parent.villages : Village
  end
end
