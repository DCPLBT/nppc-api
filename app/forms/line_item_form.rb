# frozen_string_literal: true

class LineItemForm < BaseForm
  attr_accessor :line_item_id

  def show
    line_item
  end

  def create
    line_item.save
  end

  def update
    line_item.update(params)
  end

  def destroy
    line_item.destroy
  end

  private

  def line_item
    @line_item ||= line_item_id ? LineItem.find(line_item_id) : parent.line_items.build(params)
  end
end
