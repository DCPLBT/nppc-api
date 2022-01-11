# frozen_string_literal: true

module CartHelper
  def self.included(base)
    base.class_eval do
      before_action :authenticate_user!
    end
  end

  def cart
    user_cart
  end

  private

  def user_cart
    @user_cart ||= current_user.cart || create_user_cart
  end

  def create_user_cart
    user_cart = current_user.build_cart(session_id: current_role&.id)
    user_cart.save
    user_cart
  end
end
