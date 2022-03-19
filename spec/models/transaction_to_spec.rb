# frozen_string_literal: true

# == Schema Information
#
# Table name: transaction_tos
#
#  id                   :bigint           not null, primary key
#  transactionable_type :string           not null
#  type                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  to_id                :bigint
#  transactionable_id   :bigint           not null
#
# Indexes
#
#  index_transaction_tos_on_to_id            (to_id)
#  index_transaction_tos_on_transactionable  (transactionable_type,transactionable_id)
#
require 'rails_helper'

RSpec.describe TransactionTo, type: :model do
  context 'Association' do
    it { should belong_to :to }
  end
end
