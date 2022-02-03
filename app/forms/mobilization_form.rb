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

  def update
    mobilization.approved_by = current_user if params[:state].eql?('approved')
    mobilization.update(params).tap do |result|
      result && mobilization.approved? && decrease_stock
      result && mobilization.received? && adjust_stock
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
      mobilized_to_ids: destination_ids,
      mobilizer_ids: source_ids
    )
  end

  def decrease_stock
    mobilization.line_items.each do |li|
      li.stock.decrement!(:quantity, li.quantity)
    end
  end

  def adjust_stock # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    mobilization.line_items.each do |li|
      existing_stock = current_user.stocks.find_by(procured_on: li.stock.procured_on)
      stock = existing_stock || (
        x = li.stock.dup
        x.quantity = 0
        x.user = current_user
        x
      )
      stock.update(
        quantity: stock.quantity + li.quantity,
        user_ids: mobilization.mobilized_to_ids
      )
    end
  end
end
