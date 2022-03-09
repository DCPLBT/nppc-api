# frozen_string_literal: true

class MobilizationForm < BaseForm
  def show
    mobilization
  end

  def create
    mobilization.save.tap do |result|
      result && create_mobilizer_mobilized_to
    end
  end

  def update # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity,Metrics/AbcSize
    mobilization.approved_by = current_user if params[:state].eql?('approved')
    mobilization.update(params).tap do |result|
      result && mobilization.approved? && decrease_stock
      result && mobilization.approved? && update_approved_info
      result && mobilization.received? && adjust_stock
      result && mobilization.received? && update_received_info
    end
  end

  def destroy
    mobilization.destroy
  end

  private

  def mobilization
    @mobilization ||= id ? Mobilization.find(id) : build_mobilization
  end

  def build_mobilization
    params.merge!(
      user: current_user,
      line_items: cart.line_items
    )
    Mobilization.new(params)
  end

  def create_mobilizer_mobilized_to
    mobilization.update(
      from_id: from_id,
      to_id: to_id
    )
  end

  def decrease_stock
    mobilization.line_items.each do |li|
      li.stock.decrement!(:quantity, li.quantity)
    end
  end

  def adjust_stock # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    mobilization.line_items.each do |li|
      existing_stock = current_group.stocks.find_by(procured_on: li.stock.procured_on)
      stock = existing_stock || (
        x = li.stock.dup
        x.quantity = 0
        x.user = current_user
        x
      )
      stock.update(
        quantity: stock.quantity + li.quantity,
        group_id: mobilization.mobilized_to.id
      )
    end
  end

  def update_approved_info
    mobilization.update_columns(
      approved_by_id: current_user.id,
      approved_on: Time.current
    )
  end

  def update_received_info
    mobilization.update_columns(
      received_by_id: current_user.id,
      received_on: Time.current
    )
  end
end
