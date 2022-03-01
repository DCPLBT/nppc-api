# frozen_string_literal: true

# == Schema Information
#
# Table name: districts
#
#  id          :bigint           not null, primary key
#  description :text
#  disabled    :boolean          default(FALSE)
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  region_id   :bigint
#  user_id     :bigint           not null
#
# Indexes
#
#  index_districts_on_region_id  (region_id)
#  index_districts_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
class DistrictSerializer < ApplicationSerializer
  attributes :name, :description, :user_id, :region_id, :region_name, :disabled
end
