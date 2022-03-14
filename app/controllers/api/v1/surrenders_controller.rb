# frozen_string_literal: true

module Api
  module V1
    class SurrendersController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /surrenders
      def index
        populate = SurrenderPopulator.new(params: query_params, parent: parent, current_group: current_group)
        render_paginated_collection(populate.run)
      end

      # GET /surrenders/1
      def show
        show_surrender_form(surrender_form)
      end

      # POST /surrenders
      def create
        create_surrender_form(surrender_form)
      end

      # PATCH/PUT /surrenders/1
      def update
        update_surrender_form(surrender_form)
      end

      # DELETE /surrenders/1
      def destroy
        destroy_surrender_form(surrender_form)
      end

      def excel_download
        surrenders = SurrenderPopulator.new(
          params: query_params, parent: parent, current_group: current_group
        ).run
        file_download(
          ::SurrenderExcelSupport.new(surrenders).run,
          'Surrender.xlsx',
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        )
      end

      def pdf_download
        surrenders = SurrenderPopulator.new(
          params: query_params, parent: parent, current_group: current_group
        ).run
        file_download(
          ::Documents::Pdf::Surrender.new(surrenders: surrenders).generate,
          'Surrender.pdf',
          'application/pdf'
        )
      end

      private

      # Only allow a list of trusted parameters through.][]
      def surrender_params
        params.require(:surrender).permit(
          :region_id, :district_id, :extension_id, :state, :received_remark, :comments, :surrender_type,
          attachment_attributes: [:file]
        )
      end

      def surrender_form
        SurrenderForm.new(
          surrender_attributes
        )
      end

      def surrender_attributes
        @surrender_attributes ||= {
          current_user: current_user,
          current_group: current_group,
          id: params[:id],
          from_id: from_id,
          to_id: to_id,
          cart: cart,
          include: [:attachment]
        }
      end

      def assign_params
        surrender_attributes.merge!(params: surrender_params)
      end

      def query_params
        params.permit(
          :q, :surrendered, :received, :product_type_id, :product_id, :region_id, :district_id,
          :extension_id, :year, :from_date, :to_date
        )
      end

      def to_id # rubocop:disable Metrics/AbcSize
        return unless %w[create update].include?(action_name)

        attr = { region_id: surrender_params[:region_id], district_id: surrender_params[:district_id],
                 extension_id: surrender_params[:extension_id], village_id: surrender_params[:village_id],
                 company_id: surrender_params[:company_id] }
        @to_id ||= Group.find_by(group_attributes(to_role(surrender_params[:surrender_type]), attr))&.id
      end
    end
  end
end
