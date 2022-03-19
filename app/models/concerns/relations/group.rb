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
      belongs_to :individual, class_name: 'User', optional: true

      has_many :user_groups, inverse_of: :group
      has_many :users, through: :user_groups
      has_many :stocks, inverse_of: :group, dependent: :destroy
      has_many :transaction_froms, dependent: :destroy, foreign_key: :from_id
      has_many :transaction_tos, dependent: :destroy, foreign_key: :to_id
      has_many :requested_indents, through: :transaction_froms, source: :transactionable, source_type: 'Indent'
      has_many :forwarded_indents, through: :transaction_tos, source: :transactionable, source_type: 'Indent'
      has_many :distributors_distributions, foreign_key: :from_id, class_name: 'Distribution'
      has_many :distributed_tos_distributions, foreign_key: :to_id, class_name: 'Distribution'
      has_many :mobilizers_mobilizations, foreign_key: :from_id, class_name: 'Mobilization'
      has_many :mobilized_tos_mobilizations, foreign_key: :to_id, class_name: 'Mobilization'
      has_many :surrenderer_products, foreign_key: :from_id, class_name: 'Surrender'
      has_many :surrendered_to_products, foreign_key: :to_id, class_name: 'Surrender'
    end
  end
end
