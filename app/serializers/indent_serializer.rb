# frozen_string_literal: true

# == Schema Information
#
# Table name: indents
#
#  id              :bigint           not null, primary key
#  draft           :boolean
#  state           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  forwarded_to_id :bigint
#  requester_id    :bigint
#
# Indexes
#
#  index_indents_on_forwarded_to_id  (forwarded_to_id)
#  index_indents_on_requester_id     (requester_id)
#
class IndentSerializer < ApplicationSerializer
  attributes(
    :requester_id,
    :requester_name,
    :forwarded_to_id,
    :forwarded_to_name,
    :draft,
    :state
  )
end
