# frozen_string_literal: true

class ProductPopulator < BasePopulator
  def run
    products
      .public_send(:search, q)
      .yield_self { |products| filter_by_disabled(products) }
  end

  private

  def products
    @products ||= parent ? parent.products : Product
  end
end
