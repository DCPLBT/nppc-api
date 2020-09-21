# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  default        :boolean          default(FALSE)
#  imageable_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  imageable_id   :bigint           not null
#
# Indexes
#
#  index_photos_on_imageable_type_and_imageable_id  (imageable_type,imageable_id)
#

require 'rails_helper'

RSpec.describe Photo, type: :model do
end
