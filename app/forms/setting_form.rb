# frozen_string_literal: true

class SettingForm < BaseForm
  def show
    setting
  end

  def create
    setting.save.tap do |res|
      res && setting.indent? && create_notification(notification_attributes)
      res && setting.indent? && notify_indent_submission
    end
  end

  def update
    setting.update(params)
  end

  def destroy
    setting.destroy
  end

  private

  def setting
    @setting ||= id ? Setting.find(id) : current_user.settings.build(params)
  end

  def notification_attributes
    time = setting.meta['requisition_date'].to_time
    {
      title: 'Last date of indent submission',
      text: 'Notice for Last date for submission of indent is '\
            "#{time.strftime("#{time.day.ordinalize} %B %Y")}. "\
            'The PPP Information Management System will not allow submitting indent beyond the above mentioned date.',
      url: 'setting',
      recipient_ids: User.ids
    }
  end

  def notify_indent_submission
    SettingMailer.notify_indent_submission(setting).deliver_later
  end
end
