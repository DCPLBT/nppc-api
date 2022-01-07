# frozen_string_literal: true

# == Schema Information
#
# Table name: forwardable_forwarded_tos
#
#  id               :bigint           not null, primary key
#  forwardable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  forwardable_id   :bigint           not null
#  forwarded_to_id  :bigint           not null
#
# Indexes
#
#  index_forwardable_forwarded_tos_on_forwardable      (forwardable_type,forwardable_id)
#  index_forwardable_forwarded_tos_on_forwarded_to_id  (forwarded_to_id)
#
FactoryBot.define do
  factory :forwardable_forwarded_to do
    forwardable { nil }
    requester { nil }
  end
end
