# frozen_string_literal: true

module Relations
  module Extension
    extend ActiveSupport::Concern

    included do
      belongs_to :user
      belongs_to :district, inverse_of: :extensions
    end
  end
end
