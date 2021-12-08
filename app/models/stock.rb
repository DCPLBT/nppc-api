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
#  unit            :string
#  unit_price      :decimal(, )
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_id      :bigint           not null
#  product_type_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_stocks_on_product_id       (product_id)
#  index_stocks_on_product_type_id  (product_type_id)
#  index_stocks_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (product_type_id => product_types.id)
#  fk_rails_...  (user_id => users.id)
#
class Stock < ApplicationRecord
  include Scopes::Stock
  include Helpers::Stock
  include Delegates::Stock
  include Relations::Stock
  include Validations::Stock
  include ::Callbacks::Stock
end
