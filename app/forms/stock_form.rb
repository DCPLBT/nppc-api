# frozen_string_literal: true

class StockForm < BaseForm
  attr_accessor :group_id

  def show
    stock
  end

  def create
    stock.save
  end

  def update
    stock.update(params)
  end

  def destroy
    stock.destroy
  end

  private

  def stock
    @stock ||= id ? Stock.find(id) : build_stock
  end

  def build_stock
    params.merge!(user_id: current_user.id, group_id: group_id)
    Stock.new(params)
  end
end
