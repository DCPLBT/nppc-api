# frozen_string_literal: true

module DisplayNameAssigner
  extend ActiveSupport::Concern

  private

  def default_sender_address
    address = Mail::Address.new(ENV['MAIL_FROM'] || "no-reply@#{URI.parse(ENV['HOST_URL']).host}")
    address.display_name = ENV.fetch('MAIL_DISPLAY_NAME', Rails.application.class.module_parent.to_s)
    address
  end
end
