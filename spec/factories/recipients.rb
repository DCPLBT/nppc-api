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
FactoryBot.define do
  factory :recipient do
    notification { nil }
    user { nil }
    read { '' }
    read_at { '2022-01-29 02:18:50' }
  end
end
