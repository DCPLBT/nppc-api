# frozen_string_literal: true

# == Schema Information
#
# Table name: indents
#
#  id              :bigint           not null, primary key
#  draft           :boolean
#  quantity        :decimal(, )
#  state           :integer
#  unit            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  forwarded_to_id :bigint
#  product_id      :bigint           not null
#  product_type_id :bigint           not null
#  requester_id    :bigint
#
# Indexes
#
#  index_indents_on_forwarded_to_id  (forwarded_to_id)
#  index_indents_on_product_id       (product_id)
#  index_indents_on_product_type_id  (product_type_id)
#  index_indents_on_requester_id     (requester_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (product_type_id => product_types.id)
#
class IndentSerializer < ApplicationSerializer
  attributes(
    :product_type_id,
    :product_type_name,
    :product_id,
    :product_name,
    :requester_id,
    :requester_name,
    :forwarded_to_id,
    :forwarded_to_name,
    :quantity,
    :unit,
    :draft,
    :state
  )
end
