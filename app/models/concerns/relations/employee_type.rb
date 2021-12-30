# frozen_string_literal: true

module Relations
  module EmployeeType
    extend ActiveSupport::Concern

    included do
      belongs_to :user
    end
  end
end
