# frozen_string_literal: true

module Relations
  module Product
    extend ActiveSupport::Concern

    included do
      belongs_to :user
      belongs_to :product_type, inverse_of: :products
    end
  end
end
