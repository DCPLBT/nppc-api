module Booleans
  module Role
    extend ActiveSupport::Concern

    def reserved?
      %w[admin customer user].include?(name.downcase)
    end
  end
end
