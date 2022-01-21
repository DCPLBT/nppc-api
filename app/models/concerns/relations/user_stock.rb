# frozen_string_literal: true

module Relations
  module UserStock
    extend ActiveSupport::Concern

    included do
      belongs_to :user
      belongs_to :stock
    end
  end
end
