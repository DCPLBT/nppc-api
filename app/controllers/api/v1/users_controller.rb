# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :assign_params, only: :update

      def index
        populator = UserPopulator.new(current_user: current_user, params: query_params)
        render_paginated_collection(populator.run)
      end

      def show
        authorize(User)
        show_user_form(user_form)
      end

      def profile
        render json: UserSerializer.new(current_user, include: %i[roles profile photo])
      end

      def update
        update_user_form(user_form)
      end

      def destroy
        authorize(User)
        destroy_user_form(user_form)
      end

      private

      def user_params
        params.require(:user).permit(
          user_attributes
        )
      end

      def user_form
        UserForm.new(
          user_attrs
        )
      end

      def user_attrs
        @user_attrs ||= {
          current_user: current_user,
          id: params[:id],
          include: %i[roles profile photo]
        }
      end

      def assign_params
        user_attrs.merge!(params: user_params)
      end

      def query_params
        params.permit(
          :q,
          :status,
          :region_id,
          :district_id,
          :extension_id,
          roles: []
        )
      end
    end
  end
end
