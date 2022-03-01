# frozen_string_literal: true

# == Schema Information
#
# Table name: product_types
#
#  id          :bigint           not null, primary key
#  description :text
#  disabled    :boolean          default(FALSE)
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_product_types_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe ProductType, type: :model do
  context 'Validation' do
    it { should validate_presence_of(:name) }
  end
end
