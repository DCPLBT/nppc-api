# frozen_string_literal: true

class ObsoleteWorker < ApplicationWorker
  def perform(id)
    stock = Stock.find(id)
    time = stock.obsolete_date

    Notification.create(
      title: 'Obsolete product',
      text: "Product #{stock.product_name} has become obsolete on #{time.strftime("#{time.day.ordinalize} %B %Y")}",
      url: root_url.concat("inventory/#{stock.id}"),
      user_ids: stock.group&.users&.ids
    )
  end
end
