# frozen_string_literal: true

module Api
  module V1
    class SettingsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /settings
      def index
        populate = SettingPopulator.new(parent: parent, params: query_params)
        render_paginated_collection(populate.run)
      end

      # GET /settings/1
      def show
        show_setting_form(setting_form)
      end

      # POST /settings
      def create
        create_setting_form(setting_form)
      end

      # PATCH/PUT /settings/1
      def update
        update_setting_form(setting_form)
      end

      # DELETE /settings/1
      def destroy
        destroy_setting_form(setting_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def setting_params
        params.require(:setting).permit(:category, meta: {})
      end

      def setting_form
        SettingForm.new(
          setting_attributes
        )
      end

      def setting_attributes
        @setting_attributes ||= {
          current_user: current_user,
          parent: parent,
          id: params[:id]
        }
      end

      def assign_params
        setting_attributes.merge!(params: setting_params)
      end

      def query_params
        params.permit(:category)
      end
    end
  end
end
