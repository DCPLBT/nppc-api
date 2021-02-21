# frozen_string_literal: true

module Relations
  module Photo
    extend ActiveSupport::Concern

    included do
      belongs_to :imageable, polymorphic: true

      has_one_attached :image, dependent: :destroy
    end
  end
end
