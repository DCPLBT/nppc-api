# frozen_string_literal: true

module Relations
  module Cart
    extend ActiveSupport::Concern

    included do
      belongs_to :cartable, polymorphic: true

      has_many :line_items, as: :itemable, dependent: :destroy
    end
  end
end
