# frozen_string_literal: true

# == Schema Information
#
# Table name: stocks
#
#  id              :bigint           not null, primary key
#  expiry_date     :date
#  obsolete_date   :date
#  procured_on     :date
#  quantity        :decimal(, )
#  remark          :text
#  unit_price      :decimal(, )
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_id      :bigint           not null
#  product_type_id :bigint           not null
#  unit_id         :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_stocks_on_product_id       (product_id)
#  index_stocks_on_product_type_id  (product_type_id)
#  index_stocks_on_unit_id          (unit_id)
#  index_stocks_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (product_type_id => product_types.id)
#  fk_rails_...  (unit_id => units.id)
#  fk_rails_...  (user_id => users.id)
#
class StockSerializer < ApplicationSerializer
  attributes(
    :product_type_id,
    :product_type_name,
    :product_id,
    :product_name,
    :user_id,
    :quantity,
    :unit_id,
    :unit_name,
    :unit_price,
    :total_price,
    :expiry_date,
    :procured_on,
    :obsolete_date,
    :remark,
    :created_at
  )
end
