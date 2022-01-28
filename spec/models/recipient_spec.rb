# frozen_string_literal: true

# == Schema Information
#
# Table name: recipients
#
#  id              :bigint           not null, primary key
#  read            :boolean          default(FALSE)
#  read_at         :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notification_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_recipients_on_notification_id  (notification_id)
#  index_recipients_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (notification_id => notifications.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Recipient, type: :model do
  context 'Associations' do
    it { should belong_to :user }
    it { should belong_to :notification }
  end
end
