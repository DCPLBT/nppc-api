# frozen_string_literal: true

class ProductForm < BaseForm
  attr_accessor :p_id

  def show
    product
  end

  def create
    product.save
  end

  def update
    product.update(params)
  end

  def destroy
    product.destroy
  end

  private

  def product
    @product ||= p_id ? Product.find(p_id) : parent.products.build(params.merge(user_id: current_user.id))
  end
end
