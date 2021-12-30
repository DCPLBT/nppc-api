# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  description     :text
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_type_id :bigint           not null
#  unit_id         :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_products_on_product_type_id  (product_type_id)
#  index_products_on_unit_id          (unit_id)
#  index_products_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_type_id => product_types.id)
#  fk_rails_...  (unit_id => units.id)
#  fk_rails_...  (user_id => users.id)
#
class ProductSerializer < ApplicationSerializer
  attributes :name, :description, :unit_id, :unit_name, :user_id, :product_type_id, :product_type_name
end
