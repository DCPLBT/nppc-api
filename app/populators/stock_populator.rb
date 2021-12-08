# frozen_string_literal: true

class StockPopulator < BasePopulator
  def run
    stocks
      .public_send(:search, q)
  end

  private

  def stocks
    @stocks ||= Stock.includes(:product_type, :product)
  end
end
