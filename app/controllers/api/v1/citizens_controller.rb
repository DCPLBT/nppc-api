# frozen_string_literal: true

module Api
  module V1
    class CitizensController < ApplicationController
      skip_before_action :authenticate_user!, only: :show

      def show
        show_citizen_form(citizen_form)
      end

      private

      def citizen_form
        CitizenForm.new(
          cid: params[:id],
          include: [:profile]
        )
      end
    end
  end
end
