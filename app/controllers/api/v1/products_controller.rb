# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /products
      def index
        populate = ProductPopulator.new(params: query_params, parent: parent)
        render_paginated_collection(populate.run)
      end

      # GET /products/1
      def show
        show_product_form(product_form)
      end

      # POST /products
      def create
        create_product_form(product_form)
      end

      # PATCH/PUT /products/1
      def update
        update_product_form(product_form)
      end

      # DELETE /products/1
      def destroy
        destroy_product_form(product_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def product_params
        params.require(:product).permit(:name, :description, :unit_id, :pack_size, :disabled)
      end

      def product_form
        ProductForm.new(
          product_attributes
        )
      end

      def product_attributes
        @product_attributes ||= {
          current_user: current_user,
          parent: parent,
          p_id: params[:id]
        }
      end

      def assign_params
        product_attributes.merge!(params: product_params)
      end

      def query_params
        params.permit(:q, :disabled)
      end
    end
  end
end
