# frozen_string_literal: true

module Relations
  module Distribution
    extend ActiveSupport::Concern

    included do
      belongs_to :region, optional: true
      belongs_to :district, optional: true
      belongs_to :extension, optional: true
      belongs_to :company, optional: true
      belongs_to :village, optional: true
      belongs_to :distributor, foreign_key: :from_id, class_name: 'Group', optional: true
      belongs_to :distributed_to, foreign_key: :to_id, class_name: 'Group', optional: true
      belongs_to :user

      has_one :attachment, as: :attachable, dependent: :destroy

      has_many :line_items, as: :itemable, dependent: :destroy

      has_rich_text :received_remark

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
