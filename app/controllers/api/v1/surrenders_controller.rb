# frozen_string_literal: true

module Api
  module V1
    class SurrendersController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /surrenders
      def index
        populate = SurrenderPopulator.new(params: query_params, parent: parent, current_user: current_user)
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
          id: params[:id],
          source_ids: source_ids,
          destination_ids: destination_ids,
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

      def destination_ids
        return unless params[:surrender].present?

        region_id, district_id, extension_id, company_id = extract_ids(surrender_params[:surrender_type])
        @destination_ids ||= User.includes(:roles).similar_users(
          surrender_params[:surrender_type], region_id, district_id, extension_id, company_id
        ).pluck(:id)
      end
    end
  end
end
