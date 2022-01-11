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
FactoryBot.define do
  factory :cart do
    cartable { nil }
    quantity { "9.99" }
    amount { "9.99" }
    session_id { "" }
  end
end