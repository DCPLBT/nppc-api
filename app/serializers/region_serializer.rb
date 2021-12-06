# frozen_string_literal: true

# == Schema Information
#
# Table name: regions
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_regions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class RegionSerializer < ApplicationSerializer
  attributes :name, :description, :user_id
end
