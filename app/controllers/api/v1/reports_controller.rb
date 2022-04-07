# frozen_string_literal: true

module Api
  module V1
    class ReportsController < ApplicationController
      def index
        populate = OverallReportPopulator.new(
          current_user: current_user, current_role: current_role, current_group: current_group, params: query_params
        )
        render_paginated_collection(
          populate.run, serializer: DistributionReportSerializer, params: { submitted: query_params[:submitted] }
        )
      end

      def indent
        populate = IndentReportPopulator.new(
          current_user: current_user, current_role: current_role, current_group: current_group, params: query_params
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

      def mobilization
        populate = ReportPopulator.new(
          current_user: current_user, current_role: current_role, current_group: current_group,
          params: query_params.merge!(type: 'Mobilization')
        )
        render_paginated_collection(populate.run, serializer: ReportSerializer)
      end

      def excel_download # rubocop:disable Metrics/MethodLength
        populator = case module_name
                    when 'Indent'
                      IndentReportPopulator
                    when 'Reports'
                      OverallReportPopulator
                    else
                      ReportPopulator
                    end
        line_items = populator.new(
          current_user: current_user, current_role: current_role, current_group: current_group,
          params: query_params.merge!(type: module_name)
        ).run
        file_download(
          ::ReportLineItemExcelSupport.new(line_items).run,
          'Product.xlsx',
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        )
      end

      def pdf_download # rubocop:disable Metrics/MethodLength
        populator = case module_name
                    when 'Indent'
                      IndentReportPopulator
                    when 'Reports'
                      OverallReportPopulator
                    else
                      ReportPopulator
                    end
        line_items = populator.new(
          current_user: current_user, current_role: current_role, current_group: current_group,
          params: query_params.merge!(type: module_name)
        ).run
        file_download(
          ::Documents::Pdf::ReportLineItem.new(line_items: line_items).generate,
          'Product.pdf',
          'application/pdf'
        )
      end

      private

      def query_params
        params.permit(
          :product_type_id, :product_id, :from_date, :to_date, :received, :submitted, :region_id, :district_id,
          :extension_id, :company_id, :distributed_type, :distributed_by, :village_id, :sale_agent_id
        )
      end

      def module_name
        @module_name ||= nested_route[nested_route.size - 2].camelize
      end
    end
  end
end
