# frozen_string_literal: true

# == Schema Information
#
# Table name: group_transactions
#
#  id                   :bigint           not null, primary key
#  transactionable_type :string           not null
#  type                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  group_id             :bigint           not null
#  transactionable_id   :bigint           not null
#
# Indexes
#
#  index_group_transactions_on_group_id         (group_id)
#  index_group_transactions_on_transactionable  (transactionable_type,transactionable_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#
FactoryBot.define do
  factory :group_transaction do
    transactionable { nil }
    group { nil }
  end
end
