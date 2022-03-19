# frozen_string_literal: true

# == Schema Information
#
# Table name: transaction_froms
#
#  id                   :bigint           not null, primary key
#  transactionable_type :string           not null
#  type                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  from_id              :bigint
#  transactionable_id   :bigint           not null
#
# Indexes
#
#  index_transaction_froms_on_from_id          (from_id)
#  index_transaction_froms_on_transactionable  (transactionable_type,transactionable_id)
#
FactoryBot.define do
  factory :transaction_from do
    transactionable { nil }
    from { nil }
  end
end
