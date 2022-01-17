# frozen_string_literal: true

module Relations
  module Company
    extend ActiveSupport::Concern

    included do
      belongs_to :user

      has_rich_text :description
    end
  end
end
