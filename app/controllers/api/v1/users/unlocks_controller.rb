# frozen_string_literal: true

module Api
  module V1
    module Users
      class UnlocksController < Devise::UnlocksController
        def respond_with(resource, _opts = {})
          if resource.errors?
            invalid_resource(resource)
          else
            render json: UserSerializer.new(resource, include: %i[roles])
          end
        end
      end
    end
  end
end
