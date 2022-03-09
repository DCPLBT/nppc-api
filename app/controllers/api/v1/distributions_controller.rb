# frozen_string_literal: true

module Api
  module V1
    class DistributionsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /distributions
      def index
        populate = DistributionPopulator.new(params: query_params, current_group: current_group,
                                             current_user: current_user)
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
          :region_id, :district_id, :extension_id, :village_id, :company_id, :state, :received_remark,
          :consumer_cid, :consumer_name, :consumer_village, :distributed_type, consumer_ids: [],
                                                                               attachment_attributes: [:file]
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
          current_group: current_group,
          id: params[:id],
          from_id: from_id,
          to_id: to_id,
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
          :extension_id, :year, :from_date, :to_date, :distributed_type
        )
      end

      def to_id # rubocop:disable Metrics/AbcSize
        return unless %w[create update].include?(action_name)

        attr = { region_id: distribution_params[:region_id], district_id: distribution_params[:district_id],
                 extension_id: distribution_params[:extension_id], village_id: distribution_params[:village_id],
                 company_id: distribution_params[:company_id] }
        @to_id ||= Group.find_by(group_attributes(to_role(distribution_params[:distributed_type]), attr))&.id
      end
    end
  end
end
