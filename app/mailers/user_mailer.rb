class UserMailer < Devise::Mailer
  include DisplayNameAssigner

  default from: proc { default_sender_address.format }

  before_action :set_logo

  private

  def set_logo
    attachments.inline['logo.png'] = File.read("#{Rails.root}/public/logo.png")
  end
end
