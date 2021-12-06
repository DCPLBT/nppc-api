# frozen_string_literal: true

module Api
  module V1
    class DistrictsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /districts
      def index
        populate = DistrictPopulator.new(params: query_params, parent: parent)
        render_paginated_collection(populate.run)
      end

      # GET /districts/1
      def show
        show_district_form(district_form)
      end

      # POST /districts
      def create
        create_district_form(district_form)
      end

      # PATCH/PUT /districts/1
      def update
        update_district_form(district_form)
      end

      # DELETE /districts/1
      def destroy
        destroy_district_form(district_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def district_params
        params.require(:district).permit(:name, :description)
      end

      def district_form
        DistrictForm.new(
          district_attributes
        )
      end

      def district_attributes
        @district_attributes ||= {
          current_user: current_user,
          parent: parent,
          district_id: params[:id]
        }
      end

      def assign_params
        district_attributes.merge!(params: district_params)
      end

      def query_params
        params.permit(:q)
      end
    end
  end
end
