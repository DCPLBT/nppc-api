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

    # rubocop:disable Style/MissingRespondToMissing
    def method_missing(method_sym, *_args)
      role?(method_sym.to_s.delete('?').to_sym)
    end
    # rubocop:enable Style/MissingRespondToMissing
  end
end
