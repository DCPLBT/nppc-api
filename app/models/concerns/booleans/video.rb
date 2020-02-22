module Booleans
  module Video
    extend ActiveSupport::Concern

    included do
      def changed_for_autosave?
        super || !attachment_changes.empty?
      end
    end

    def correct_clip_type?
      clip.attached? && clip.content_type.in?(%w[video/mp4 video/quicktime video/webm])
    end
  end
end
