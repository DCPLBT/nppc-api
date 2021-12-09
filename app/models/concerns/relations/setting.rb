# frozen_string_literal: true

module Relations
  module Setting
    extend ActiveSupport::Concern

    included do
      belongs_to :user, inverse_of: :settings
    end
  end
end
