# frozen_string_literal: true

# == Schema Information
#
# Table name: agencies
#
#  id               :bigint           not null, primary key
#  description      :text
#  disabled         :boolean          default(FALSE)
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  employee_type_id :bigint
#  user_id          :bigint           not null
#
# Indexes
#
#  index_agencies_on_employee_type_id  (employee_type_id)
#  index_agencies_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_type_id => employee_types.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Agency, type: :model do
  context 'Validation' do
    it { should validate_presence_of(:name) }
  end
end
