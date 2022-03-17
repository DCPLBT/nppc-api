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
require 'rails_helper'

RSpec.describe GroupTransaction, type: :model do
  context 'Association' do
    it { should belong_to(:group) }
  end
end
