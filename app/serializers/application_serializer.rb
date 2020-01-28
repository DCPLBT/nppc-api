class ApplicationSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers

  def time_in_words(date)
    return if date.nil?

    "#{time_ago_in_words(date)} ago"
  end

  def created_ago
    time_in_words(object.created_at)
  end

  def created_date
    object.created_at.strftime('%d %b, %Y')
  end
end
