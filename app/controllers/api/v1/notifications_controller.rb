# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      # GET /notifications
      def index
        populate = NotificationPopulator.new(params: query_params, current_user: current_user)
        render_paginated_collection(populate.run)
      end

      # GET /notifications/1
      def show
        show_notification_form(notification_form)
      end

      private

      def notification_form
        NotificationForm.new(
          notification_attributes
        )
      end

      def notification_attributes
        @notification_attributes ||= {
          current_user: current_user,
          id: params[:id]
        }
      end

      def query_params
        params.permit(:q)
      end
    end
  end
end