module Booleans
  module Photo
    extend ActiveSupport::Concern

    def correct_image_type?
      image.attached? && image.content_type.in?(%w[image/png image/jpg image/gif image/jpeg])
    end
  end
end
