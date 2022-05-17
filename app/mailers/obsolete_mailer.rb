# frozen_string_literal: true

class ObsoleteMailer < ApplicationMailer
  def notify_obsolete_product(stock)
    @stock = Stock.find(id)
    @time = stock.obsolete_date
    mail(to: stock.group&.users&.pluck(:email))
  end
end
