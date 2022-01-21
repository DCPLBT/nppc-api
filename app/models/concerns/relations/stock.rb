# frozen_string_literal: true

module Relations
  module Stock
    extend ActiveSupport::Concern

    included do
      belongs_to :product_type
      belongs_to :product
      belongs_to :user
      belongs_to :unit

      has_many :user_stocks, dependent: :destroy
      has_many :users, through: :user_stocks
    end
  end
end
