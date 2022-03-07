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
    line_item.update(params).tap do |result|
      result && line_item.received? && update_received_info
    end
  end

  def destroy
    line_item.destroy
  end

  private

  def line_item
    @line_item ||= line_item_id ? LineItem.find(line_item_id) : parent.line_items.build(params)
  end

  def update_received_info
    line_item.update_columns(
      received_by_id: current_user.id,
      received_on: Time.current
    )
  end
end
