# frozen_string_literal: true

module Relations
  module Role
    extend ActiveSupport::Concern

    included do
      has_and_belongs_to_many :users, inverse_of: :roles

      has_many :employee_types, inverse_of: :role
    end
  end
end
