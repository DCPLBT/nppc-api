# frozen_string_literal: true

# == Schema Information
#
# Table name: line_items
#
#  id              :bigint           not null, primary key
#  itemable_type   :string           not null
#  quantity        :decimal(, )
#  unit            :string
#  unit_price      :decimal(, )
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  itemable_id     :bigint           not null
#  product_id      :bigint           not null
#  product_type_id :bigint           not null
#
# Indexes
#
#  index_line_items_on_itemable         (itemable_type,itemable_id)
#  index_line_items_on_product_id       (product_id)
#  index_line_items_on_product_type_id  (product_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (product_type_id => product_types.id)
#
require 'rails_helper'

RSpec.describe LineItem, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:quantity) }
  end
end
