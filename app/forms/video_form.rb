# frozen_string_literal: true

class VideoForm < BaseForm
  def create
    video.save
  end

  def update
    video.update(params)
  end

  def destroy
    video.destroy
  end

  private

  def video
    @video ||= id ? Video.find(id) : determine_singularity
  end

  def determine_singularity
    parent.respond_to?(:photo) ? parent.build_video(params) : parent.videos.build(params)
  end
end
