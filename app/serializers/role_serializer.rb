# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class RoleSerializer < ApplicationSerializer
  attributes(
    :id,
    :name,
    :description
  )
end
