module Validations
  module Photo
    extend ActiveSupport::Concern

    included do
      validates_presence_of :image
      validate :image_content_type
    end

    def image_content_type
      errors.add(:image, :file_is_not_image) unless correct_image_type?
    end
  end
end