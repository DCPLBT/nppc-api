# frozen_string_literal: true

class DesignationPopulator < BasePopulator
  def run
    designations
      .public_send(:search, q)
      .yield_self { |designations| filter_by_disabled(designations) }
  end

  private

  def designations
    @designations ||= (parent ? parent.designations : Designation).includes(:user)
  end
end
