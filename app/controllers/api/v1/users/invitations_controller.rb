# frozen_string_literal: true

module Api
  module V1
    module Users
      class InvitationsController < Devise::InvitationsController
        before_action :invite_parameter_sanitizer, only: :create
        before_action :accept_parameter_sanitizer, only: :update

        def check
          user = User.find(params[:id])
          render json: { accepted: user.invitation_accepted? }
        end

        def respond_with(resource, _opts = {})
          if resource.errors?
            invalid_resource(resource)
          else
            render json: UserSerializer.new(resource, include: %i[roles profile photo])
          end
        end

        private

        def invite_parameter_sanitizer
          devise_parameter_sanitizer.permit(
            :invite,
            keys: user_attributes
          )
        end

        def accept_parameter_sanitizer
          devise_parameter_sanitizer.permit(
            :accept_invitation,
            keys: user_attributes
          )
        end
      end
    end
  end
end
