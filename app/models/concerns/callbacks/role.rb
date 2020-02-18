module Callbacks
  module Role
    extend ActiveSupport::Concern

    included do
      before_destroy :check_for_reserved_name
    end

    def check_for_reserved_name
      return unless reserved?

      errors.add(:name, :name_is_reserved, name: name)
      throw :abort
    end
  end
end
