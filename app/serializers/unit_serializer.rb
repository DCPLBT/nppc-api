# frozen_string_literal: true

# == Schema Information
#
# Table name: units
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
#  index_units_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UnitSerializer < ApplicationSerializer
  attributes :name, :description, :user_id, :user_name
end
