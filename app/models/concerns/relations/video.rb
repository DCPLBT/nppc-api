# frozen_string_literal: true

module Relations
  module Video
    extend ActiveSupport::Concern

    included do
      belongs_to :clipable, polymorphic: true

      has_one_attached :clip, dependent: :destroy
    end
  end
end
