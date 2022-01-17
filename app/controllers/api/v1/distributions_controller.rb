# frozen_string_literal: true

module Api
  module V1
    class DistributionsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /distributions
      def index
        populate = DistributionPopulator.new(params: query_params, parent: parent, current_user: current_user)
        render_paginated_collection(populate.run)
      end

      # GET /distributions/1
      def show
        show_distribution_form(distribution_form)
      end

      # POST /distributions
      def create
        create_distribution_form(distribution_form)
      end

      # PATCH/PUT /distributions/1
      def update
        update_distribution_form(distribution_form)
      end

      # DELETE /distributions/1
      def destroy
        destroy_distribution_form(distribution_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def distribution_params
        params.require(:distribution).permit(
          :region_id, :district_id, :extension_id, :state, :received_remark, :consumer_cid, :consumer_name,
          :consumer_village, :distributed_type, consumer_ids: [], attachment_attributes: [:file]
        )
      end

      def distribution_form
        DistributionForm.new(
          distribution_attributes
        )
      end

      def distribution_attributes
        @distribution_attributes ||= {
          current_user: current_user,
          id: params[:id],
          source_ids: source_ids,
          destination_ids: destination_ids,
          cart: cart,
          include: [:attachment]
        }
      end

      def assign_params
        distribution_attributes.merge!(params: distribution_params)
      end

      def query_params
        params.permit(
          :q, :distributed, :received, :product_type_id, :product_id, :region_id, :district_id,
          :extension_id, :year
        )
      end

      def destination_ids
        return unless params[:distribution].present?

        @destination_ids ||= User.includes(:roles).similar_users(
          distribute_to_role, distribution_params[:region_id], distribution_params[:district_id],
          distribution_params[:extension_id]
        ).pluck(:id)
      end

      def distribute_to_role
        case distribution_params[:distributed_type]
        when 'self', 'individual'
          'user'
        else
          distribution_params[:distributed_type]
        end
      end
    end
  end
end
