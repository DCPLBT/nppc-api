# frozen_string_literal: true

class NotificationPopulator < BasePopulator
  def run
    notifications
      .public_send(:search, q)
  end

  private

  def notifications
    @notifications ||= current_user.notifications
  end
end
