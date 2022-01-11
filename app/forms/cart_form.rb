# frozen_string_literal: true

class CartForm < BaseForm
  attr_accessor :cart

  def index
    update_cart
    cart
  end

  private

  def update_cart
    return if line_items.empty?

    cart.update(
      quantity: line_items.sum(&:quantity),
      amount: line_items.sum(&:total_price)
    )
  end

  def line_items
    @line_items ||= cart.line_items
  end
end
