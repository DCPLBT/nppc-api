# frozen_string_literal: true

module Relations
  module District
    extend ActiveSupport::Concern

    included do
      belongs_to :user
      belongs_to :region, inverse_of: :districts, optional: true

      has_many :extensions, inverse_of: :district, dependent: :destroy
    end
  end
end
