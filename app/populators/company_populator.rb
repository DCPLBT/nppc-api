# frozen_string_literal: true

class CompanyPopulator < BasePopulator
  def run
    companies
      .public_send(:search, q)
      .yield_self { |companies| filter_by_disabled(companies) }
  end

  private

  def companies
    @companies ||= (parent ? parent.companies : Company).includes(:user)
  end
end
