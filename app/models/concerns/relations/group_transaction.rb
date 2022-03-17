# frozen_string_literal: true

module Relations
  module GroupTransaction
    extend ActiveSupport::Concern

    included do
      belongs_to :transactionable, polymorphic: true
      belongs_to :group
    end
  end
end
