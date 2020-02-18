# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  default        :boolean
#  imageable_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  imageable_id   :bigint           not null
#
# Indexes
#
#  index_photos_on_imageable_type_and_imageable_id  (imageable_type,imageable_id)
#

class Photo < ApplicationRecord
  include Booleans::Photo
  include Delegates::Photo
  include Relations::Photo
  include Validations::Photo
end
