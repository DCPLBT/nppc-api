module Overrides
  module User
    extend ActiveSupport::Concern

    included do
      attr_accessor :login

      def self.find_for_database_authentication(warden_conditions)
        conditions = warden_conditions.dup
        if (login = conditions.delete(:login))
          where(conditions.to_h).where(
            ':value in (username, email, phone)',
            value: login.downcase
          ).first
        else
          where(conditions.to_h).first
        end
      end

      def update_with_password(params = {})
        params.delete(:password) if params[:password].blank?
        params.delete(:password_confirmation) if params[:password_confirmation].blank?
        update_attributes(params)
      end

      def self.confirm_by_token(confirmation_token)
        resource = super
        resource.update_column(:active, true) unless resource.errors?
        resource
      end

      def self.accept_invitation!(update_resource_params)
        resource = super
        resource.update_column(:active, true) unless resource.errors?
        resource
      end
    end
  end
end
