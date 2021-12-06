# frozen_string_literal: true

module Api
  module V1
    module Users
      class ConfirmationsController < Devise::ConfirmationsController
        def show
          super do
            sign_in(resource) unless resource.errors?
          end
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
