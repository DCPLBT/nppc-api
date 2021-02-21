# frozen_string_literal: true

# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  default        :boolean          default(FALSE)
#  imageable_type :string           not null
#  type           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  imageable_id   :bigint           not null
#
# Indexes
#
#  index_photos_on_imageable_type_and_imageable_id  (imageable_type,imageable_id)
#

class PhotoSerializer < ApplicationSerializer
  SMALL = '120X120'
  MEDIUM = '320X180'
  LARGE = '500X250'

  attributes(
    :id,
    :default,
    :filename,
    :byte_size,
    :small,
    :medium,
    :large,
    :original
  )

  def small
    ImageService.new(object.image, SMALL).generate if object.image.attached?
  end

  def medium
    ImageService.new(object.image, MEDIUM).generate if object.image.attached?
  end

  def large
    ImageService.new(object.image, LARGE).generate if object.image.attached?
  end

  def original
    rails_blob_url(object.image) if object.image.attached?
  end
end
