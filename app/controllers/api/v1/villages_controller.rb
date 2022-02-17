# frozen_string_literal: true

module Api
  module V1
    class VillagesController < ApplicationController
      before_action :assign_params, only: %i[create update]
      skip_before_action :authenticate_user!, only: :index

      # GET /villages
      def index
        populate = VillagePopulator.new(params: query_params, parent: parent)
        render_paginated_collection(populate.run)
      end

      # GET /villages/1
      def show
        show_village_form(village_form)
      end

      # POST /villages
      def create
        create_village_form(village_form)
      end

      # PATCH/PUT /villages/1
      def update
        update_village_form(village_form)
      end

      # DELETE /villages/1
      def destroy
        destroy_village_form(village_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def village_params
        params.require(:village).permit(:name, :description)
      end

      def village_form
        VillageForm.new(
          village_attributes
        )
      end

      def village_attributes
        @village_attributes ||= {
          current_user: current_user,
          parent: parent,
          village_id: params[:id]
        }
      end

      def assign_params
        village_attributes.merge!(params: village_params)
      end

      def query_params
        params.permit(:q)
      end
    end
  end
end
