# frozen_string_literal: true

class NotificationForm < BaseForm
  def show
    mark_read_notification
    notification
  end

  private

  def notification
    @notification ||= Notification.find(id)
  end

  def mark_read_notification
    recipient = notification.recipients.find_by(user_id: current_user.id)
    recipient&.update(read: true, read_at: Time.current)
  end
end
