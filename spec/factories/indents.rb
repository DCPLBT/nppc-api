# frozen_string_literal: true

# == Schema Information
#
# Table name: indents
#
#  id              :bigint           not null, primary key
#  draft           :boolean
#  reference_no    :string
#  state           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  forwarded_to_id :bigint
#  requester_id    :bigint
#  stock_id        :bigint
#
# Indexes
#
#  index_indents_on_forwarded_to_id  (forwarded_to_id)
#  index_indents_on_requester_id     (requester_id)
#  index_indents_on_stock_id         (stock_id)
#
# Foreign Keys
#
#  fk_rails_...  (stock_id => stocks.id)
#
FactoryBot.define do
  factory :indent do
    requester { nil }
    forwarded_to { nil }
    draft { false }
    state { 0 }
  end
end
