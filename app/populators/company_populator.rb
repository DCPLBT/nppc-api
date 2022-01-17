# frozen_string_literal: true

class CompanyPopulator < BasePopulator
  def run
    companies
      .public_send(:search, q)
  end

  private

  def companies
    @companies ||= (parent ? parent.companies : Company).includes(:user)
  end
end
