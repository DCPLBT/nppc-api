# frozen_string_literal: true

class DistributionForm < BaseForm
  def show
    distribution
  end

  def create
    distribution.save.tap do |result|
      result && create_distributor_distributed_to
      result && decrease_stock
    end
  end

  def update
    distribution.update(params).tap do |result|
      result && distribution.received? && adjust_stock
    end
  end

  def destroy
    distribution.destroy
  end

  private

  def distribution
    @distribution ||= id ? Distribution.find(id) : build_distribution
  end

  def build_distribution
    params.merge!(
      user: current_user,
      line_items: cart.line_items
    )
    Distribution.new(params)
  end

  def create_distributor_distributed_to
    distribution.update(
      distributed_to_ids: destination_ids,
      distributor_ids: source_ids
    )
  end

  def decrease_stock
    distribution.line_items.each do |li|
      li.stock.decrement!(:quantity, li.quantity)
    end
  end

  def adjust_stock # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    distribution.line_items.each do |li|
      existing_stock = current_user.stocks.find_by(procured_on: li.stock.procured_on)
      stock = existing_stock || (x = li.stock.dup
                                 x.quantity = 0
                                 x.user = current_user
                                 x)
      stock.update(
        quantity: stock.quantity + li.quantity,
        user_ids: distribution.distributed_to_ids
      )
    end
  end
end
