# frozen_string_literal: true

class VillageSerializer < ApplicationSerializer
  attributes(
    :name,
    :description,
    :user_id,
    :extension_id,
    :extension_name
  )
end
