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

class Photo < ApplicationRecord
  include Scopes::Photo
  include Booleans::Photo
  include Delegates::Photo
  include Relations::Photo
  include Validations::Photo
end
