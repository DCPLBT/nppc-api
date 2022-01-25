# frozen_string_literal: true

module Relations
  module Surrender
    extend ActiveSupport::Concern

    included do
      belongs_to :region, optional: true
      belongs_to :district, optional: true
      belongs_to :extension, optional: true
      belongs_to :user

      has_one :attachment, as: :attachable, dependent: :destroy

      has_many :line_items, as: :itemable, dependent: :destroy
      has_many :forwardable_forwarded_tos, as: :forwardable, dependent: :destroy
      has_many :requestable_requesters, as: :requestable, dependent: :destroy
      has_many :surrendered_tos, through: :forwardable_forwarded_tos, source: :forwarded_to
      has_many :surrenderers, through: :requestable_requesters, source: :requester

      has_rich_text :received_remark
      has_rich_text :comments

      accepts_nested_attributes_for(
        :attachment,
        update_only: true
      )
      accepts_nested_attributes_for(
        :line_items,
        limit: 1,
        allow_destroy: true
      )
    end
  end
end
