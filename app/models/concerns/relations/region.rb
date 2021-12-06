# frozen_string_literal: true

module Relations
  module Region
    extend ActiveSupport::Concern

    included do
      belongs_to :user, inverse_of: :regions

      has_many :districts, inverse_of: :region, dependent: :destroy
    end
  end
end
