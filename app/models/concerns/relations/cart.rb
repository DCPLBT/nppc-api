# frozen_string_literal: true

module Relations
  module Cart
    extend ActiveSupport::Concern

    included do
      belongs_to :cartable, polymorphic: true

      has_many :line_items, as: :itemable, dependent: :destroy
      has_many :requestable_requesters, as: :requestable, dependent: :destroy
      has_many :cart_users, through: :requestable_requesters, source: :requester
    end
  end
end
