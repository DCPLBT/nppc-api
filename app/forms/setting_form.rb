# frozen_string_literal: true

class SettingForm < BaseForm
  def show
    setting
  end

  def create
    setting.save
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
end
