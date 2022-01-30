# frozen_string_literal: true

class BaseForm
  include Pundit
  include Assigner
  include Rails.application.routes.url_helpers

  attr_accessor(
    :current_user,
    :include,
    :parent,
    :params,
    :id,
    :next_role_name,
    :current_role_name,
    :source_ids,
    :destination_ids,
    :cart
  )

  def initialize(attributes = {})
    assign_attributes(attributes)
  end

  def create_notification(attr = { title: nil, text: '', url: '', recipient_ids: [] })
    Notification.create(
      title: attr[:title],
      text: attr[:text],
      url: root_url.concat(attr[:url]),
      user_ids: attr[:recipient_ids]
    )
  end
end
