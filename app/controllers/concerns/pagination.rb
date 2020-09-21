module Pagination
  def paginate(resource)
    {
      previous: resource.prev,
      current: resource.page,
      next_page: resource.next,
      last_page: resource.last,
      total: resource.count
    }
  end

  def render_paginated_collection(resource, serializer = nil, options = {})
    config, collection = paginated_collection(resource)
    render paginated_data(collection, config, serializer, options)
  end

  def paginated_collection(resource)
    pagy(
      resource,
      page: params.fetch(:page, 1),
      items: params.fetch(:per_page, 10)
    )
  end

  def paginated_data(collection, config, serializer, options)
    options[:meta] = paginate(config)
    options[:params] = { current_user: current_user }
    {
      json: collection_serializer(collection, serializer).new(collection, options).serialized_json,
      status: :ok
    }
  end

  def collection_serializer(obj, serializer)
    serializer.present? ? serializer : "#{obj.class.to_s.deconstantize}Serializer".constantize
  end
end
