# frozen_string_literal: true

module Api
  module V1
    class IndentsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /indents
      def index
        populate = IndentPopulator.new(params: query_params, current_user: current_user, current_group: current_group)
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

      def excel_download
        indents = IndentPopulator.new(
          params: query_params, current_user: current_user, current_group: current_group
        ).run
        file_download(
          ::IndentExcelSupport.new(indents).run,
          'Indent.xlsx',
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        )
      end

      def pdf_download
        indents = IndentPopulator.new(
          params: query_params, current_user: current_user, current_group: current_group
        ).run
        file_download(
          ::Documents::Pdf::Indent.new(indents: indents).generate,
          'Indent.pdf',
          'application/pdf'
        )
      end

      private

      # Only allow a list of trusted parameters through.
      def indent_params
        params.require(:indent).permit(
          :draft, :state, :remark, :region_id, :district_id, :extension_id, :company_id,
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
          from_id: from_id,
          to_id: to_id,
          next_role_name: next_role_name,
          submitted: params[:submitted]
        }
      end

      def assign_params
        indent_attributes.merge!(params: indent_params)
      end

      def query_params
        params.permit(
          :q, :draft, :requested, :received, :product_type_id, :product_id, :region_id, :district_id,
          :extension_id, :year, :from_date, :to_date
        )
      end

      def to_id
        return unless %w[create update forward].include?(action_name)

        attr = { region_id: indent_params[:region_id], district_id: indent_params[:district_id],
                 extension_id: indent_params[:extension_id], village_id: indent_params[:village_id],
                 company_id: indent_params[:company_id] }
        @to_id ||= Group.find_by(group_attributes(next_role, attr))&.id
      end
    end
  end
end
