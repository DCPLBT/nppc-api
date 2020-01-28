class ImageService < BaseService
  attr_accessor(
    :image,
    :image_size
  )

  def initialize(image, image_size)
    @image = image
    @image_size = image_size
  end

  def generate
    send(image_size.to_s)
  end

  private

  def method_missing(method_sym, *_args)
    generate_image(method_sym) || super
  end

  def respond_to_missing?(method, *)
    super
  end

  def generate_image(size)
    rails_representation_url(
      image.variant(resize: size).processed
    )
  end
end
