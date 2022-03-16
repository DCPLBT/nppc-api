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

  def update # rubocop:disable Metrics/CyclomaticComplexity,Metrics/AbcSize,Metrics/PerceivedComplexity
    mobilization.approved_by = current_user if params[:state].eql?('approved')
    mobilization.update(params).tap do |result|
      result && mobilization.approved? && decrease_stock
      result && mobilization.approved? && update_approved_info
      result && mobilization.received? && update_received_info
      result && mobilization.rejected? && update_rejected_info
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

  def update_rejected_info
    mobilization.update_columns(
      rejected_by_id: current_user.id,
      rejected_on: Time.current
    )
  end
end
