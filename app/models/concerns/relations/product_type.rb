# frozen_string_literal: true

module Relations
  module ProductType
    extend ActiveSupport::Concern

    included do
      belongs_to :user

      has_many :products, inverse_of: :product_type, dependent: :destroy
    end
  end
end
