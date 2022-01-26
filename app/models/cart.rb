# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id            :bigint           not null, primary key
#  amount        :decimal(, )
#  cartable_type :string           not null
#  category      :integer
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
class Cart < ApplicationRecord
  include Enums::Cart
  include Relations::Cart
  include Validations::Cart
end
