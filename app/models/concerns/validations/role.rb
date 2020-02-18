module Validations
  module Role
    extend ActiveSupport::Concern

    included do
      validates_uniqueness_of :name, case_sensitive: false
    end
  end
end
