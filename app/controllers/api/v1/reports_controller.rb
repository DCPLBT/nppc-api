# frozen_string_literal: true

module Api
  module V1
    class ReportsController < ApplicationController
      def index
        populate = ReportPopulator.new(current_user: current_user, params: query_params)
        render_paginated_collection(populate.run, serializer: DistributionReportSerializer)
      end

      private

      def query_params
        params.permit(:report_type)
      end
    end
  end
end
