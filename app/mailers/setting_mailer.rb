# frozen_string_literal: true

class SettingMailer < ApplicationMailer
  def notify_indent_submission(setting)
    @setting = setting
    @time = setting.meta['requisition_date']&.to_time
    mail(to: User.pluck(:email))
  end
end
