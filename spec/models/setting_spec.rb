# frozen_string_literal: true

# == Schema Information
#
# Table name: settings
#
#  id         :bigint           not null, primary key
#  category   :integer
#  meta       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_settings_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Setting, type: :model do
  context 'Validation' do
    it { should validate_presence_of(:category) }
  end
end
