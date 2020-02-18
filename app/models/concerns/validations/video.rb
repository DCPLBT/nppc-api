module Validations
  module Video
    extend ActiveSupport::Concern

    included do
      validates_presence_of :clip
      validate :clip_content_type
    end

    def clip_content_type
      errors.add(:clip, :file_is_not_video) unless correct_clip_type?
    end
  end
end
