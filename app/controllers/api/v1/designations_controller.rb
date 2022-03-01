# frozen_string_literal: true

module Api
  module V1
    class DesignationsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /Designations
      def index
        populate = DesignationPopulator.new(params: query_params)
        render_paginated_collection(populate.run)
      end

      # GET /Designations/1
      def show
        show_designation_form(designation_form)
      end

      # POST /Designations
      def create
        create_designation_form(designation_form)
      end

      # PATCH/PUT /Designations/1
      def update
        update_designation_form(designation_form)
      end

      # DELETE /Designations/1
      def destroy
        destroy_designation_form(designation_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def designation_params
        params.require(:designation).permit(:name, :description, :disabled)
      end

      def designation_form
        DesignationForm.new(
          designation_attributes
        )
      end

      def designation_attributes
        @designation_attributes ||= {
          current_user: current_user,
          id: params[:id]
        }
      end

      def assign_params
        designation_attributes.merge!(params: designation_params)
      end

      def query_params
        params.permit(:q, :disabled)
      end
    end
  end
end
