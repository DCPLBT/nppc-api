# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /companys
      def index
        populate = CompanyPopulator.new(params: query_params)
        render_paginated_collection(populate.run)
      end

      # GET /companys/1
      def show
        show_company_form(company_form)
      end

      # POST /companys
      def create
        create_company_form(company_form)
      end

      # PATCH/PUT /companys/1
      def update
        update_company_form(company_form)
      end

      # DELETE /companys/1
      def destroy
        destroy_company_form(company_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def company_params
        params.require(:company).permit(:name, :description)
      end

      def company_form
        CompanyForm.new(
          company_attributes
        )
      end

      def company_attributes
        @company_attributes ||= {
          current_user: current_user,
          id: params[:id]
        }
      end

      def assign_params
        company_attributes.merge!(params: company_params)
      end

      def query_params
        params.permit(:q)
      end
    end
  end
end
