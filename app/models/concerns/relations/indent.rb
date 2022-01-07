# frozen_string_literal: true

module Relations
  module Indent
    extend ActiveSupport::Concern

    included do
      belongs_to :region, optional: true
      belongs_to :district, optional: true
      belongs_to :extension, optional: true

      has_rich_text :remark

      has_many :line_items, as: :itemable, dependent: :destroy
      has_many :forwardable_forwarded_tos, as: :forwardable, dependent: :destroy
      has_many :requestable_requesters, as: :requestable, dependent: :destroy
      has_many :forwarded_tos, through: :forwardable_forwarded_tos
      has_many :requesters, through: :requestable_requesters

      accepts_nested_attributes_for(
        :line_items,
        allow_destroy: true
      )
    end
  end
end
