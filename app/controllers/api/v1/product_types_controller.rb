# frozen_string_literal: true

module Api
  module V1
    class ProductTypesController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /product_types
      def index
        populate = ProductTypePopulator.new(params: query_params)
        render_paginated_collection(populate.run)
      end

      # GET /product_types/1
      def show
        show_product_type_form(product_type_form)
      end

      # POST /product_types
      def create
        create_product_type_form(product_type_form)
      end

      # PATCH/PUT /product_types/1
      def update
        update_product_type_form(product_type_form)
      end

      # DELETE /product_types/1
      def destroy
        destroy_product_type_form(product_type_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def product_type_params
        params.require(:product_type).permit(:name, :description)
      end

      def product_type_form
        ProductTypeForm.new(
          product_type_attributes
        )
      end

      def product_type_attributes
        @product_type_attributes ||= {
          current_user: current_user,
          id: params[:id]
        }
      end

      def assign_params
        product_type_attributes.merge!(params: product_type_params)
      end

      def query_params
        params.permit(:q)
      end
    end
  end
end
