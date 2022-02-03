# frozen_string_literal: true

module Api
  module V1
    class MobilizationsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /mobilizations
      def index
        populate = MobilizationPopulator.new(params: query_params, parent: parent, current_user: current_user)
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
          id: params[:id],
          source_ids: source_ids,
          destination_ids: destination_ids,
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
          :extension_id, :year, :approved, :rejected
        )
      end

      def destination_ids
        return unless params[:mobilization].present?

        region_id, district_id, extension_id, company_id = extract_ids(mobilization_params[:category])
        @destination_ids ||= User.includes(:roles).similar_users(
          mobilization_params[:category], region_id, district_id, extension_id, company_id
        ).pluck(:id)
      end

      def extract_ids(role_name)
        case role_name
        when 'ea'
          [mobilization_params[:region_id], mobilization_params[:district_id], mobilization_params[:extension_id]]
        when 'adrc'
          [mobilization_params[:region_id]]
        when 'mhv'
          [nil, nil, nil, mobilization_params[:company_id]]
        else
          []
        end
      end
    end
  end
end
