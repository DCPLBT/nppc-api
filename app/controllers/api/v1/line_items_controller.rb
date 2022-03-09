# frozen_string_literal: true

module Api
  module V1
    class LineItemsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      def index
        populate = LineItemPopulator.new(parent: parent, params: query_params)
        render_paginated_collection(populate.run)
      end

      def show
        show_line_item_form(line_item_form)
      end

      def create
        create_line_item_form(line_item_form)
      end

      def update
        update_line_item_form(line_item_form)
      end

      def destroy
        destroy_line_item_form(line_item_form)
      end

      private

      def line_item_params
        params.require(:line_item).permit(
          :product_type_id, :product_id, :stock_id, :quantity, :unit_id, :received, :received_quantity,
          :received_remark
        )
      end

      def line_item_form
        LineItemForm.new(
          line_item_attributes
        )
      end

      def line_item_attributes
        @line_item_attributes ||= {
          current_user: current_user,
          current_group: current_group,
          parent: parent,
          line_item_id: params[:id],
          include: [:itemable]
        }
      end

      def assign_params
        line_item_attributes.merge!(params: line_item_params)
      end

      def query_params
        params.permit(:q)
      end
    end
  end
end
