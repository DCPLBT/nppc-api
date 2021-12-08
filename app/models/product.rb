# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  description     :text
#  name            :string
#  unit            :string
#  unit_size       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_type_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_products_on_product_type_id  (product_type_id)
#  index_products_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_type_id => product_types.id)
#  fk_rails_...  (user_id => users.id)
#
class Product < ApplicationRecord
  include Scopes::Product
  include Delegates::Product
  include Relations::Product
  include Validations::Product
end
