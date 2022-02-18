# frozen_string_literal: true

# == Schema Information
#
# Table name: villages
#
#  id           :bigint           not null, primary key
#  description  :text
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  extension_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_villages_on_extension_id  (extension_id)
#  index_villages_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (extension_id => extensions.id)
#  fk_rails_...  (user_id => users.id)
#
class VillageSerializer < ApplicationSerializer
  attributes(
    :name,
    :description,
    :user_id,
    :extension_id,
    :extension_name
  )
end
