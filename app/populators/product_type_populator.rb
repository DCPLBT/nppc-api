# frozen_string_literal: true

class ProductTypePopulator < BasePopulator
  def run
    product_types
      .public_send(:search, q)
      .yield_self { |product_types| filter_by_disabled(product_types) }
  end

  private

  def product_types
    @product_types ||= ProductType
  end
end
