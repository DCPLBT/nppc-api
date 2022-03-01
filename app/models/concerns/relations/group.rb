# frozen_string_literal: true

module Relations
  module Group
    extend ActiveSupport::Concern

    included do
      belongs_to :role
      belongs_to :region, optional: true
      belongs_to :district, optional: true
      belongs_to :extension, optional: true
      belongs_to :village, optional: true
      belongs_to :company, optional: true

      has_many :user_groups, inverse_of: :group
      has_many :users, through: :user_groups
      has_many :requested_indents, foreign_key: :from_id, class_name: 'Indent'
      has_many :forwarded_indents, foreign_key: :to_id, class_name: 'Indent'
    end
  end
end