# frozen_string_literal: true

class ObsoleteMailer < ApplicationMailer
  def notify_obsolete_product(stock)
    @stock = stock
    @time = stock.obsolete_date
    emails = stock.group.users.pluck(:email) + User.includes(:roles).select(&:nppc?).pluck(:email)
    mail(to: emails)
  end
end
