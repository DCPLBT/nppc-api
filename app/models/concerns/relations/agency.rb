# frozen_string_literal: true

module Relations
  module Agency
    extend ActiveSupport::Concern

    included do
      belongs_to :user
      belongs_to :employee_type, inverse_of: :agencies

      has_many :designations, inverse_of: :agency, dependent: :destroy
    end
  end
end
