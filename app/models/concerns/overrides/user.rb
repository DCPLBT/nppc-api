module Overrides
  module User
    extend ActiveSupport::Concern

    included do
      attr_accessor :login

      def self.find_for_database_authentication(warden_conditions)
        conditions = warden_conditions.dup
        if (login = conditions.delete(:login))
          where(conditions.to_h).where(
            'username = :value OR email = :value OR phone = :value',
            value: login.downcase
          ).first
        else
          where(conditions.to_h).first
        end
      end
    end
  end
end
