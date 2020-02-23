module Callbacks
  module Role
    extend ActiveSupport::Concern

    included do
      before_destroy :check_for_reserved_name
      before_update :check_for_reserved_name_update
    end

    def check_for_reserved_name
      return unless reserved?(name)

      errors.add(:name, :name_is_reserved, name: name)
      throw :abort
    end

    def check_for_reserved_name_update
      return unless reserved?(name_in_database)

      errors.add(:name, :name_is_reserved, name: name_in_database)
      throw :abort
    end
  end
end
