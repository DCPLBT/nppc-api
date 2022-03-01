# frozen_string_literal: true

module Api
  module V1
    class UnitsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /units
      def index
        populate = UnitPopulator.new(params: query_params)
        render_paginated_collection(populate.run)
      end

      # GET /units/1
      def show
        show_unit_form(unit_form)
      end

      # POST /units
      def create
        create_unit_form(unit_form)
      end

      # PATCH/PUT /units/1
      def update
        update_unit_form(unit_form)
      end

      # DELETE /units/1
      def destroy
        destroy_unit_form(unit_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def unit_params
        params.require(:unit).permit(:name, :description, :disabled)
      end

      def unit_form
        UnitForm.new(
          unit_attributes
        )
      end

      def unit_attributes
        @unit_attributes ||= {
          current_user: current_user,
          id: params[:id]
        }
      end

      def assign_params
        unit_attributes.merge!(params: unit_params)
      end

      def query_params
        params.permit(:q, :disabled)
      end
    end
  end
end
