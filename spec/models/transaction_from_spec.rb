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
require 'rails_helper'

RSpec.describe TransactionFrom, type: :model do
  context 'Association' do
    it { should belong_to :from }
  end
end
