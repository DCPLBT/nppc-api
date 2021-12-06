# frozen_string_literal: true

module Api
  module V1
    class RegionsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /regions
      def index
        binding.pry
        populate = RegionPopulator.new(params: query_params)
        render_paginated_collection(populate.run)
      end

      # GET /regions/1
      def show
        show_region_form(region_form)
      end

      # POST /regions
      def create
        create_region_form(region_form)
      end

      # PATCH/PUT /regions/1
      def update
        update_region_form(region_form)
      end

      # DELETE /regions/1
      def destroy
        destroy_region_form(region_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def region_params
        params.require(:region).permit(:name, :description)
      end

      def region_form
        RegionForm.new(
          region_attributes
        )
      end

      def region_attributes
        @region_attributes ||= {
          current_user: current_user,
          id: params[:id]
        }
      end

      def assign_params
        region_attributes.merge!(params: region_params)
      end

      def query_params
        params.permit(:q)
      end
    end
  end
end
