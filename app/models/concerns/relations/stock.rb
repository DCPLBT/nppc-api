# frozen_string_literal: true

module Relations
  module Stock
    extend ActiveSupport::Concern

    included do
      belongs_to :product_type
      belongs_to :product
      belongs_to :user
      belongs_to :unit
      belongs_to :group, inverse_of: :stocks
    end
  end
end
