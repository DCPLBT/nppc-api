# frozen_string_literal: true

module Relations
  module Stock
    extend ActiveSupport::Concern

    included do
      belongs_to :product_type
      belongs_to :product
      belongs_to :user
    end
  end
end
