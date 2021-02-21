# frozen_string_literal: true

module Booleans
  module Photo
    extend ActiveSupport::Concern

    included do
      def changed_for_autosave?
        super || !attachment_changes.empty?
      end
    end

    def correct_image_type?
      image.attached? && image.content_type.in?(%w[image/png image/jpg image/gif image/jpeg])
    end
  end
end
