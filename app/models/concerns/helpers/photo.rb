# frozen_string_literal: true

module Helpers
  module Photo
    extend ActiveSupport::Concern

    SMALL = '120X120'
    MEDIUM = '180X320'
    LARGE = '250X500'

    def small
      ImageService.new(image: image, image_size: SMALL).generate if image.attached?
    end

    def medium
      ImageService.new(image: image, image_size: MEDIUM).generate if image.attached?
    end

    def large
      ImageService.new(image: image, image_size: LARGE).generate if image.attached?
    end

    def original
      rails_blob_url(image) if image.attached?
    end
  end
end
