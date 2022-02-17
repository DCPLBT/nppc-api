# frozen_string_literal: true

class VillagePopulator < BasePopulator
  def run
    villages
      .public_send(:search, q)
  end

  private

  def villages
    @villages ||= parent ? parent.villages : Village
  end
end
