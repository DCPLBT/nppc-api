# frozen_string_literal: true

module Relations
  module Indent
    extend ActiveSupport::Concern

    included do
      belongs_to :requester, class_name: 'User'
      belongs_to :forwarded_to, optional: true, class_name: 'User'

      has_rich_text :remark

      has_many :line_items, as: :itemable, dependent: :destroy

      accepts_nested_attributes_for(
        :line_items,
        allow_destroy: true
      )
    end
  end
end
