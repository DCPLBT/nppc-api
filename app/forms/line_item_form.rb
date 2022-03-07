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
      result && line_item.received? && update_parent_state
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

  def update_parent_state
    return unless line_item.itemable.line_items.all?(&:received?)
    return unless line_item.itemable.respond_to?(:state)
    return unless line_item.itemable.class.states.keys.include?('received')

    line_item.itemable.update(
      state: :received
    )
  end
end
