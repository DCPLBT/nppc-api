# == Schema Information
#
# Table name: videos
#
#  id            :bigint           not null, primary key
#  clipable_type :string           not null
#  default       :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  clipable_id   :bigint           not null
#
# Indexes
#
#  index_videos_on_clipable_type_and_clipable_id  (clipable_type,clipable_id)
#

require 'rails_helper'

RSpec.describe Video, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
