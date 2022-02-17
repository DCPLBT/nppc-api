# frozen_string_literal: true

module Relations
  module Village
    extend ActiveSupport::Concern

    included do
      belongs_to :user
      belongs_to :extension, inverse_of: :villages
    end
  end
end
