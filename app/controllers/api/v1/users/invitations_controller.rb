module Api
  module V1
    module Users
      class InvitationsController < Devise::InvitationsController
        before_action :invite_parameter_sanitizer, only: :create

        def respond_with(resource, _opts = {})
          if resource.errors?
            invalid_resource(resource)
          else
            render json: resource
          end
        end

        private

        def invite_parameter_sanitizer
          devise_parameter_sanitizer.permit(
            :invite,
            keys: user_attributes
          )
        end
      end
    end
  end
end