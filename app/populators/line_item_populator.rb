# frozen_string_literal: true

class LineItemPopulator < BasePopulator
  def run
    line_items
      .public_send(:search, q)
  end

  private

  def line_items
    @line_items ||= (parent ? parent.line_items : LineItem).includes(:product, :product_type, :unit)
  end
end
