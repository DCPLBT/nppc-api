# frozen_string_literal: true

module Relations
  module Indent
    extend ActiveSupport::Concern

    included do
      belongs_to :region, optional: true
      belongs_to :district, optional: true
      belongs_to :extension, optional: true
      belongs_to :company, optional: true
      belongs_to :user
      belongs_to :accepted_by, class_name: 'User', optional: true
      belongs_to :forwarded_by, class_name: 'User', optional: true
      belongs_to :received_by, class_name: 'User', optional: true

      has_many :line_items, as: :itemable, dependent: :destroy
      has_many :transaction_froms, as: :transactionable, dependent: :destroy
      has_many :transaction_tos, as: :transactionable, dependent: :destroy
      has_many :requesters, through: :transaction_froms, source: :from
      has_many :forwarded_tos, through: :transaction_tos, source: :to

      has_rich_text :remark

      accepts_nested_attributes_for(
        :line_items,
        allow_destroy: true
      )
    end
  end
end
