# frozen_string_literal: true

module CartHelper
  attr_accessor :category

  def self.included(base)
    base.class_eval do
      before_action :authenticate_user!
    end
  end

  def cart
    @category = params[:category]
    raise ArgumentError, 'Cart category is required' unless category.present?
    raise ArgumentError, "Invalid cart category, expected values are #{Cart.categories.keys}" unless correct_category?

    user_cart
  end

  private

  def user_cart
    @user_cart ||= current_user.carts.find_by(category: category) || create_user_cart
  end

  def create_user_cart
    user_cart = Cart.new(
      session_id: current_role&.id,
      cartable: current_user,
      category: params[:category]
    )
    user_cart.save
    user_cart
  end

  def correct_category?
    Cart.categories.keys.include? category
  end
end
