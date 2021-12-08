# frozen_string_literal: true

class ProductPopulator < BasePopulator
  def run
    products
      .public_send(:search, q)
  end

  private

  def products
    @products ||= parent ? parent.products : Product
  end
end
