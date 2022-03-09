# frozen_string_literal: true

module Api
  module V1
    class MobilizationsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /mobilizations
      def index
        populate = MobilizationPopulator.new(params: query_params, parent: parent, current_group: current_group)
        render_paginated_collection(populate.run)
      end

      # GET /mobilizations/1
      def show
        show_mobilization_form(mobilization_form)
      end

      # POST /mobilizations
      def create
        create_mobilization_form(mobilization_form)
      end

      # PATCH/PUT /mobilizations/1
      def update
        update_mobilization_form(mobilization_form)
      end

      # DELETE /mobilizations/1
      def destroy
        destroy_mobilization_form(mobilization_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def mobilization_params
        params.require(:mobilization).permit(
          :region_id, :district_id, :extension_id, :company_id, :state, :received_remark, :remark,
          :approved_by_id, :category, attachment_attributes: [:file]
        )
      end

      def mobilization_form
        MobilizationForm.new(
          mobilization_attributes
        )
      end

      def mobilization_attributes
        @mobilization_attributes ||= {
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
        mobilization_attributes.merge!(params: mobilization_params)
      end

      def query_params
        params.permit(
          :q, :mobilized, :received, :product_type_id, :product_id, :region_id, :district_id,
          :extension_id, :year, :approved, :rejected, :from_date, :to_date
        )
      end

      def to_id # rubocop:disable Metrics/AbcSize
        return unless %w[create update].include?(action_name)

        attr = { region_id: mobilization_params[:region_id], district_id: mobilization_params[:district_id],
                 extension_id: mobilization_params[:extension_id], village_id: mobilization_params[:village_id],
                 company_id: mobilization_params[:company_id] }
        @to_id ||= Group.find_by(group_attributes(to_role(mobilization_params[:category]), attr))&.id
      end
    end
  end
end
