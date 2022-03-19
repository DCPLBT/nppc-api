# frozen_string_literal: true

module Api
  module V1
    class ReportsController < ApplicationController
      def index
        populate = ReportPopulator.new(
          current_user: current_user, current_role: current_role, current_group: current_group,
          params: query_params.merge!(type: 'Distribution')
        )
        render_paginated_collection(populate.overall, serializer: DistributionReportSerializer)
      end

      def indent
        populate = ReportPopulator.new(
          current_user: current_user, current_role: current_role, current_group: current_group,
          params: query_params.merge!(type: 'Indent')
        )
        render_paginated_collection(populate.run, serializer: ReportSerializer)
      end

      def distribution
        populate = ReportPopulator.new(
          current_user: current_user, current_role: current_role, current_group: current_group,
          params: query_params.merge!(type: 'Distribution')
        )
        render_paginated_collection(populate.run, serializer: ReportSerializer)
      end

      def surrender
        populate = ReportPopulator.new(
          current_user: current_user, current_role: current_role, current_group: current_group,
          params: query_params.merge!(type: 'Surrender')
        )
        render_paginated_collection(populate.run, serializer: ReportSerializer)
      end

      def stock
        populate = ReportPopulator.new(
          current_user: current_user, current_role: current_role, current_group: current_group,
          params: query_params.merge!(type: 'Stock')
        )
        render_paginated_collection(populate.run, serializer: ReportSerializer)
      end

      def mobilization
        populate = ReportPopulator.new(
          current_user: current_user, current_role: current_role, current_group: current_group,
          params: query_params.merge!(type: 'Mobilization')
        )
        render_paginated_collection(populate.run, serializer: ReportSerializer)
      end

      private

      def query_params
        params.permit(
          :product_type_id, :product_id, :from_date, :to_date, :received, :submitted, :region_id, :district_id,
          :extension_id, :company_id, :distributed_type, :distributed_by, :village, :sale_agent_id
        )
      end
    end
  end
end
