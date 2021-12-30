# frozen_string_literal: true

# == Schema Information
#
# Table name: line_items
#
#  id              :bigint           not null, primary key
#  itemable_type   :string           not null
#  quantity        :decimal(, )
#  unit_price      :decimal(, )
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  itemable_id     :bigint           not null
#  product_id      :bigint           not null
#  product_type_id :bigint           not null
#  unit_id         :bigint           not null
#
# Indexes
#
#  index_line_items_on_itemable         (itemable_type,itemable_id)
#  index_line_items_on_product_id       (product_id)
#  index_line_items_on_product_type_id  (product_type_id)
#  index_line_items_on_unit_id          (unit_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (product_type_id => product_types.id)
#  fk_rails_...  (unit_id => units.id)
#
FactoryBot.define do
  factory :line_item do
    product_type { nil }
    product { nil }
    itemable { nil }
    quantity { '9.99' }
    unit { 'MyString' }
  end
end
