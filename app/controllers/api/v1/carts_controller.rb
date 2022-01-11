module Api
  module V1
    class CartsController < ApplicationController
      # GET /carts
      def index
        index_cart_form(cart_form)
      end

      private

      def cart_form
        CartForm.new(
          cart_attributes
        )
      end

      def cart_attributes
        @cart_attributes ||= {
          cart: cart
        }
      end
    end
  end
end
