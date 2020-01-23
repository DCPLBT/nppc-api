class ApplicationMailer < ActionMailer::Base
  default from: proc { default_sender_address.format }
  layout 'mailer'

  private

  def default_sender_address
    address = Mail::Address.new("no-reply@#{URI.parse(ENV['HOST_URL']).host}")
    address.display_name = ENV.fetch('MAIL_DISPLAY_NAME', Rails.application.class.parent.to_s)
    address
  end
end
