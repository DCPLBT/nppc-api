# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        def respond_with(resource, _opts = {})
          if resource.errors?
            invalid_resource(resource)
          else
            render json: resource
          end
        end

        def respond_to_on_destroy
          head :ok
        end
      end
    end
  end
end
