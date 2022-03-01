# frozen_string_literal: true

module Api
  module V1
    class ExtensionsController < ApplicationController
      before_action :assign_params, only: %i[create update]
      skip_before_action :authenticate_user!, only: :index

      # GET /extensions
      def index
        populate = ExtensionPopulator.new(params: query_params, parent: parent)
        render_paginated_collection(populate.run)
      end

      # GET /extensions/1
      def show
        show_extension_form(extension_form)
      end

      # POST /extensions
      def create
        create_extension_form(extension_form)
      end

      # PATCH/PUT /extensions/1
      def update
        update_extension_form(extension_form)
      end

      # DELETE /extensions/1
      def destroy
        destroy_extension_form(extension_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def extension_params
        params.require(:extension).permit(:name, :description, :disabled)
      end

      def extension_form
        ExtensionForm.new(
          extension_attributes
        )
      end

      def extension_attributes
        @extension_attributes ||= {
          current_user: current_user,
          parent: parent,
          extension_id: params[:id]
        }
      end

      def assign_params
        extension_attributes.merge!(params: extension_params)
      end

      def query_params
        params.permit(:q, :disabled)
      end
    end
  end
end
