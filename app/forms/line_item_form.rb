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
      result && line_item.received? && adjust_stock
      result && line_item.received? && update_parent_state
    end
  end

  def destroy
    line_item.destroy
  end

  private

  def line_item
    @line_item ||= line_item_id ? LineItem.find(line_item_id) : merge_similar_products
  end

  def merge_similar_products # rubocop:disable Metrics/AbcSize
    return parent.line_items.build(params) unless parent.is_a?(Cart)

    li = parent.line_items.find_by(
      product_type_id: params[:product_type_id], product_id: params[:product_id], stock_id: params[:stock_id]
    )
    if li
      li.assign_attributes(quantity: li.quantity + (params[:quantity]&.to_d || 0))
      li
    else
      parent.line_items.build(params)
    end
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

  def adjust_stock # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    return unless line_item.itemable.respond_to?(:to_id) && line_item.respond_to?(:stock)

    existing_stock = current_group.stocks.find_by(
      procured_on: line_item.stock&.procured_on,
      product_type_id: line_item.product_type_id,
      product_id: line_item.product_id
    )
    stock = existing_stock || (
      x = line_item.stock.dup
      x.quantity = 0
      x.user = current_user
      x
    )
    stock.update(
      quantity: stock.quantity + line_item.received_quantity,
      group_id: line_item.itemable.to_id
    )
  end
end
