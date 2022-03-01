# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  description     :text
#  disabled        :boolean          default(FALSE)
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
require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'Validation' do
    it { should validate_presence_of(:name) }
  end
end
