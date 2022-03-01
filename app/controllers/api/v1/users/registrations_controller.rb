# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        before_action :configure_account_update_params, only: :update
        before_action :configure_account_create_params, only: :create

        def create # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
          build_resource(sign_up_params)
          resource.define_singleton_method(:password_required?) { false }

          resource.save
          yield resource if block_given?
          if resource.persisted?
            if resource.active_for_authentication?
              set_flash_message! :notice, :signed_up
              sign_up(resource_name, resource)
              respond_with resource, location: after_sign_up_path_for(resource)
            else
              set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
              expire_data_after_sign_in!
              respond_with resource, location: after_inactive_sign_up_path_for(resource)
            end
          else
            clean_up_passwords resource
            set_minimum_password_length
            respond_with resource
          end
        end

        protected

        def configure_account_update_params
          devise_parameter_sanitizer.permit(:account_update, keys: user_attributes)
        end

        def configure_account_create_params
          devise_parameter_sanitizer.permit(:sign_up, keys: user_attributes)
        end

        def respond_with(resource, _opts = {})
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
