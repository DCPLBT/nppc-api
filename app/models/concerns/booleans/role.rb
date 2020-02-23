module Booleans
  module Role
    extend ActiveSupport::Concern

    def reserved?(role)
      reserved_keys = %w[admin customer user]
      reserved_keys.include?(role.delete(' ').underscore)
    end
  end
end
