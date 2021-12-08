# frozen_string_literal: true

class StockForm < BaseForm
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
    @stock ||= id ? Stock.find(id) : Stock.new(params.merge(user_id: current_user.id))
  end
end
