# frozen_string_literal: true

module Relations
  module Group
    extend ActiveSupport::Concern

    included do
      belongs_to :role
      belongs_to :region
      belongs_to :district
      belongs_to :extension
      belongs_to :village
      belongs_to :company

      has_many :user_groups, inverse_of: :group
      has_many :users, through: :user_groups
    end
  end
end
