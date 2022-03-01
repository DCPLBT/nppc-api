# frozen_string_literal: true

module Api
  module V1
    class EmployeeTypesController < ApplicationController
      before_action :assign_params, only: %i[create update]

      # GET /employee_types
      def index
        populate = EmployeeTypePopulator.new(params: query_params)
        render_paginated_collection(populate.run)
      end

      # GET /employee_types/1
      def show
        show_employee_type_form(employee_type_form)
      end

      # POST /employee_types
      def create
        create_employee_type_form(employee_type_form)
      end

      # PATCH/PUT /employee_types/1
      def update
        update_employee_type_form(employee_type_form)
      end

      # DELETE /employee_types/1
      def destroy
        destroy_employee_type_form(employee_type_form)
      end

      private

      # Only allow a list of trusted parameters through.
      def employee_type_params
        params.require(:employee_type).permit(:name, :description, :disabled)
      end

      def employee_type_form
        EmployeeTypeForm.new(
          employee_type_attributes
        )
      end

      def employee_type_attributes
        @employee_type_attributes ||= {
          current_user: current_user,
          id: params[:id]
        }
      end

      def assign_params
        employee_type_attributes.merge!(params: employee_type_params)
      end

      def query_params
        params.permit(:q, :disabled)
      end
    end
  end
end
