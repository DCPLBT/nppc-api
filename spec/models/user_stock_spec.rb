# frozen_string_literal: true

# == Schema Information
#
# Table name: user_stocks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stock_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_stocks_on_stock_id  (stock_id)
#  index_user_stocks_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (stock_id => stocks.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserStock, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
