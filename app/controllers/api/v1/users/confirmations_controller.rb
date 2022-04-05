# frozen_string_literal: true

module Api
  module V1
    module Users
      class ConfirmationsController < Devise::ConfirmationsController
        def show
          super do
            resource.update(password: params[:password])
            sign_in(resource) unless resource.errors?
          end
        end

        def check
          user = resource_class.find_first_by_auth_conditions(confirmation_token: params[:confirmation_token])

          unless user
            confirmation_digest = Devise.token_generator.digest(self, :confirmation_token, params[:confirmation_token])
            user = resource_class.find_or_initialize_with_error_by(:confirmation_token, confirmation_digest)
          end
          render json: { confirmed: user.confirmed? }
        end

        protected

        def respond_with(_, _opts = {})
          if resource.errors?
            invalid_resource(resource)
          else
            render json: UserSerializer.new(resource, include: %i[roles profile photo])
          end
        end
      end
    end
  end
end
