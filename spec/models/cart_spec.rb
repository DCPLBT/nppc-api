# == Schema Information
#
# Table name: carts
#
#  id            :bigint           not null, primary key
#  amount        :decimal(, )
#  cartable_type :string           not null
#  quantity      :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  cartable_id   :bigint           not null
#  session_id    :bigint
#
# Indexes
#
#  index_carts_on_cartable  (cartable_type,cartable_id)
#
require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'Associations' do
    it { should have_many(:line_items) }
  end
end
