# frozen_string_literal: true

module Api
  module V1
    class AgenciesController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /agencys
      def index
        populate = AgencyPopulator.new(params: query_params, parent: parent)
        render_paginated_collection(populate.run)
      end

      # GET /agencys/1
      def show
        show_agency_form(agency_form)
      end

      # POST /agencys
      def create
        create_agency_form(agency_form)
      end

      # PATCH/PUT /agencys/1
      def update
        update_agency_form(agency_form)
      end

      # DELETE /agencys/1
      def destroy
        destroy_agency_form(agency_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def agency_params
        params.require(:agency).permit(:name, :description, :disabled, :employee_type_id)
      end

      def agency_form
        AgencyForm.new(
          agency_attributes
        )
      end

      def agency_attributes
        @agency_attributes ||= {
          current_user: current_user,
          id: params[:id]
        }
      end

      def assign_params
        agency_attributes.merge!(params: agency_params)
      end

      def query_params
        params.permit(:q, :disabled)
      end
    end
  end
end
