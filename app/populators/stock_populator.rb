# frozen_string_literal: true

class StockPopulator < BasePopulator
  attr_accessor :product_type_id, :product_id

  def run
    stocks
      .public_send(:search, q)
      .yield_self { |stocks| filter_by_product_type(stocks) }
      .yield_self { |stocks| filter_by_product(stocks) }
  end

  private

  def stocks
    @stocks ||= current_user.stocks.includes(:product_type, :product, :unit)
  end

  def filter_by_product_type(stocks)
    return stocks unless product_type_id.present?

    stocks.filter_by_product_type(product_type_id)
  end

  def filter_by_product(stocks)
    return stocks unless product_id.present?

    stocks.filter_by_product(product_id)
  end
end
