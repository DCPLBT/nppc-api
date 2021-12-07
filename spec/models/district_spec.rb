# frozen_string_literal: true

# == Schema Information
#
# Table name: districts
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  region_id   :bigint
#  user_id     :bigint           not null
#
# Indexes
#
#  index_districts_on_region_id  (region_id)
#  index_districts_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe District, type: :model do
  context 'Validation' do
    it { should validate_presence_of(:name) }
  end
end
