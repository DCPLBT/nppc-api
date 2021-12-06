# frozen_string_literal: true

module Api
  module V1
    module Users
      class PasswordsController < Devise::PasswordsController
        def respond_with(_res, _opts = {})
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
