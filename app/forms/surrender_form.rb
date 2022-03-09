# frozen_string_literal: true

class SurrenderForm < BaseForm
  def show
    surrender
  end

  def create
    surrender.save.tap do |result|
      result && create_surrenderer_surrendered_to
      result && decrease_stock
    end
  end

  def update
    surrender.update(params).tap do |result|
      result && surrender.received? && adjust_stock
      result && surrender.received? && update_received_info
    end
  end

  def destroy
    surrender.destroy
  end

  private

  def surrender
    @surrender ||= if id
                     Surrender.includes(
                       line_items: %i[unit stock product product_type]
                     ).find(id)
                   else
                     build_surrender
                   end
  end

  def build_surrender
    params.merge!(
      user: current_user,
      line_items: cart.line_items
    )
    Surrender.includes(
      line_items: %i[unit stock product product_type]
    ).new(params)
  end

  def create_surrenderer_surrendered_to
    surrender.update(
      from_id: from_id,
      to_id: to_id
    )
  end

  def decrease_stock
    surrender.line_items.each do |li|
      li.stock.decrement!(:quantity, li.quantity)
    end
  end

  def adjust_stock # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    surrender.line_items.each do |li|
      existing_stock = current_group.stocks.find_by(procured_on: li.stock.procured_on)
      stock = existing_stock || (
        x = li.stock.dup
        x.quantity = 0
        x.user = current_user
        x
      )
      stock.update(
        quantity: stock.quantity + li.quantity,
        group_id: surrender.surrendered_to.id
      )
    end
  end

  def update_received_info
    surrender.update_columns(
      received_by_id: current_user.id,
      received_on: Time.current
    )
  end
end
