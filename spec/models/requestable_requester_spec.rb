# frozen_string_literal: true

# == Schema Information
#
# Table name: requestable_requesters
#
#  id               :bigint           not null, primary key
#  requestable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  requestable_id   :bigint           not null
#  requester_id     :bigint           not null
#
# Indexes
#
#  index_requestable_requesters_on_requestable   (requestable_type,requestable_id)
#  index_requestable_requesters_on_requester_id  (requester_id)
#
require 'rails_helper'

RSpec.describe RequestableRequester, type: :model do
  context 'Association' do
    it { should belong_to(:requestable) }
  end
end
