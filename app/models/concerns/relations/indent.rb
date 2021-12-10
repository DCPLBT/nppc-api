# frozen_string_literal: true

module Relations
  module Indent
    extend ActiveSupport::Concern

    included do
      belongs_to :product_type
      belongs_to :product
      belongs_to :requester, class_name: 'User'
      belongs_to :forwarded_to, optional: true, class_name: 'User'
    end
  end
end
