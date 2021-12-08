# frozen_string_literal: true

class ProductTypeForm < BaseForm
  def show
    product_type
  end

  def create
    product_type.save
  end

  def update
    product_type.update(params)
  end

  def destroy
    product_type.destroy
  end

  private

  def product_type
    @product_type ||= id ? ProductType.find(id) : ProductType.new(params.merge(user_id: current_user.id))
  end
end
