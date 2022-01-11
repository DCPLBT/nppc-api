# frozen_string_literal: true

module Api
  module V1
    class IndentsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /indents
      def index
        populate = IndentPopulator.new(params: query_params, current_user: current_user)
        render_paginated_collection(populate.run)
      end

      # GET /indents/1
      def show
        show_indent_form(indent_form)
      end

      # POST /indents
      def create
        create_indent_form(indent_form)
      end

      # PATCH/PUT /indents/1
      def update
        update_indent_form(indent_form)
      end

      # DELETE /indents/1
      def destroy
        destroy_indent_form(indent_form)
      end

      # GET /indents/1/forward
      def forward
        forward_indent_form(indent_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def indent_params
        params.require(:indent).permit(
          :draft, :state, :remark,
          line_items_attributes: %i[id product_type_id product_id quantity unit_id _destroy]
        )
      end

      def indent_form
        IndentForm.new(
          indent_attributes
        )
      end

      def indent_attributes
        @indent_attributes ||= {
          current_user: current_user,
          id: params[:id],
          current_role_name: current_role_name,
          next_role_name: next_role_name,
          requester_ids: source_ids,
          forwarded_to_ids: destination_ids
        }
      end

      def assign_params
        indent_attributes.merge!(params: indent_params)
      end

      def query_params
        params.permit(
          :q, :draft, :requested, :received, :product_type_id, :product_id, :region_id, :district_id,
          :extension_id, :year
        )
      end
    end
  end
end
