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
    distribution.update(params)
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
      from_id: from_id,
      to_id: to_id
    )
  end

  def decrease_stock
    distribution.line_items.each do |li|
      li.stock.decrement!(:quantity, li.quantity)
    end
  end
end
