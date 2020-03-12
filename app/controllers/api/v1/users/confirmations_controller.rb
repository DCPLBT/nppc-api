# frozen_string_literal: true

module Api
  module V1
    module Users
      class ConfirmationsController < Devise::ConfirmationsController
        def respond_with(_, _opts = {})
          if resource.errors?
            invalid_resource(resource)
          else
            render json: resource
          end
        end
      end
    end
  end
end
