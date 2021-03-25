# frozen_string_literal: true

class ImageService < BaseService
  attr_accessor(
    :image,
    :image_size
  )

  def generate
    send(image_size.to_s)
  end

  private

  def method_missing(method_sym, *_args)
    generate_image(method_sym) || super
  end

  def respond_to_missing?(method, *); end

  def generate_image(size)
    rails_representation_url(
      image.variant(resize: size).processed
    )
  end
end
