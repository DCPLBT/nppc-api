module Booleans
  module Video
    extend ActiveSupport::Concern

    def correct_clip_type?
      clip.attached? && clip.content_type.in?(%w[video/mp4 video/quicktime video/webm])
    end
  end
end
