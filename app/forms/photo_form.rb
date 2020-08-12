class PhotoForm < BaseForm
  def create
    photo.save
  end

  def update
    photo.update(params)
  end

  def destroy
    photo.destroy
  end

  private

  def photo
    @photo ||= id ? photo.find(id) : determine_singularity
  end

  def determine_singularity
    parent.respond_to?(:photo) ? parent.build_photo(params) : parent.photos.build(params)
  end
end
