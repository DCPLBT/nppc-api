module Validations
  module Photo
    extend ActiveSupport::Concern

    included do
      validates_presence_of :image
      validate :image_content_type
      validate :attached_image_size
    end

    def image_content_type
      errors.add(:image, :file_is_not_image) unless correct_image_type?
    end

    def attached_image_size
      return unless image.attached?

      errors.add(:base, :max_size_exceeded) if image.byte_size > 5.megabytes
    end
  end
end
