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
require 'rails_helper'

RSpec.describe ForwardableForwardedTo, type: :model do
  context 'Association' do
    it { should belong_to(:forwardable) }
  end
end
