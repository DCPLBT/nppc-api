# frozen_string_literal: true

class DesignationPopulator < BasePopulator
  def run
    designations
      .public_send(:search, q)
  end

  private

  def designations
    @designations ||= (parent ? parent.designations : Designation).includes(:user)
  end
end
