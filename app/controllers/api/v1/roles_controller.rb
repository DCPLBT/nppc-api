# frozen_string_literal: true

module Api
  module V1
    class RolesController < ApplicationController
      before_action :assign_params, only: %i[create update]

      def index
        render_paginated_collection(Role)
      end

      def show
        show_role_form(role_form)
      end

      def create
        create_role_form(role_form)
      end

      def update
        update_role_form(role_form)
      end

      def destroy
        destroy_role_form(role_form)
      end

      private

      def role_params
        params.require(:role).permit(
          :id,
          :name
        )
      end

      def role_form
        RoleForm.new(
          role_attributes
        )
      end

      def role_attributes
        @role_attributes ||= {
          current_user: current_user,
          id: params[:id]
        }
      end

      def assign_params
        role_attributes.merge!(params: role_params)
      end
    end
  end
end
