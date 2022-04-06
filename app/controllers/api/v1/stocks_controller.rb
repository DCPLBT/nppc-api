# frozen_string_literal: true

module Api
  module V1
    class StocksController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /stocks
      def index
        populate = StockPopulator.new(params: query_params, current_group: current_group)
        render_paginated_collection(populate.run)
      end

      # GET /stocks/1
      def show
        show_stock_form(stock_form)
      end

      # POST /stocks
      def create
        create_stock_form(stock_form)
      end

      # PATCH/PUT /stocks/1
      def update
        update_stock_form(stock_form)
      end

      # DELETE /stocks/1
      def destroy
        destroy_stock_form(stock_form)
      end

      def excel_download
        stocks = StockPopulator.new(params: query_params, current_group: current_group).run
        file_download(
          ::StockExcelSupport.new(stocks).run,
          'Stock.xlsx',
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        )
      end

      def pdf_download
        stocks = StockPopulator.new(params: query_params, current_group: current_group).run
        file_download(
          ::Documents::Pdf::Stock.new(stocks: stocks).generate,
          'Stock.pdf',
          'application/pdf'
        )
      end

      private

      # Only allow a list of trusted parameters through.
      def stock_params
        params.require(:stock).permit(
          :product_type_id, :product_id, :quantity, :unit_price, :expiry_date, :procured_on, :remark
        )
      end

      def stock_form
        StockForm.new(
          stock_attributes
        )
      end

      def stock_attributes
        @stock_attributes ||= {
          current_user: current_user,
          id: params[:id],
          group_id: current_group.id
        }
      end

      def assign_params
        stock_attributes.merge!(params: stock_params)
      end

      def query_params
        params.permit(:q, :product_type_id, :product_id, :obsolete, :from_date, :to_date, :year)
      end
    end
  end
end
