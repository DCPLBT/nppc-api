module Validations
  module Video
    extend ActiveSupport::Concern

    included do
      validates_presence_of :clip
      validate :clip_content_type
      validate :attached_video_size
    end

    def clip_content_type
      errors.add(:clip, :file_is_not_video) unless correct_clip_type?
    end

    def attached_video_size
      return unless clip.attached?

      errors.add(:base, :max_size_exceeded) if clip.byte_size > 25.megabytes
    end
  end
end
