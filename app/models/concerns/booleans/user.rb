# frozen_string_literal: true

module Booleans
  module User
    extend ActiveSupport::Concern

    included do
      def active_for_authentication?
        super && active?
      end
    end

    def role?(role)
      roles.any? { |r| r.name.delete(' ').underscore.to_sym == role }
    end

    def admin?
      role?(:admin)
    end
  end
end
